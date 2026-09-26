import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/events/domain_event_dispatcher.dart';
import '../../../core/ids/unique_id.dart';
import '../../../core/time/app_clock.dart';
import '../../template/domain/template_enums.dart';
import '../../template/domain/workout_template.dart';
import '../../template/domain/workout_template_revision.dart';
import '../../template/infrastructure/template_repository.dart';
import '../domain/audit_entry.dart';
import '../domain/execution_set.dart';
import '../domain/rest_interval.dart';
import '../domain/session_block.dart';
import '../domain/session_enums.dart';
import '../domain/session_events.dart';
import '../domain/session_interruption.dart';
import '../domain/session_item.dart';
import '../domain/workout_session.dart';
import '../infrastructure/session_repository.dart';

/// Commands for a live workout. Each successful command persists the full
/// aggregate before notifying event subscribers.
class SessionUseCases {
  const SessionUseCases({
    required ITemplateRepository templates,
    required IWorkoutSessionRepository sessions,
    required DomainEventDispatcher events,
  })  : _templates = templates,
        _sessions = sessions,
        _events = events;

  final ITemplateRepository _templates;
  final IWorkoutSessionRepository _sessions;
  final DomainEventDispatcher _events;

  Future<Result<WorkoutSession, Failure>> createFromRevision({
    required String revisionId,
    required String userId,
  }) async {
    final revisionResult = await _templates.getRevision(revisionId);
    if (revisionResult.isError) {
      return Result.error(revisionResult.errorOrNull!);
    }
    final revision = revisionResult.dataOrNull!;
    if (revision.status != TemplateRevisionStatus.published) {
      return Result.error(ConflictFailure(
          'A workout must be created from a published template revision',
          revisionId));
    }
    final templateResult = await _templates.getTemplate(revision.templateId);
    if (templateResult.isError) {
      return Result.error(templateResult.errorOrNull!);
    }
    final template = templateResult.dataOrNull!;
    final session = _cloneRevision(revision, template, userId);
    final saved = await _sessions.save(session);
    return saved.isError
        ? Result.error(saved.errorOrNull!)
        : Result.success(session);
  }

  Future<Result<WorkoutSession, Failure>> start(String id) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.draft) {
      return Result.error(
          ConflictFailure('Only a draft session can be started', id));
    }
    final now = AppClock.nowUtc();
    final starting = session.copyWith(
      status: SessionStatus.starting,
      startedAt: now,
      audits: [...session.audits, _audit(id, AuditAction.started)],
    );
    final saved = await _sessions.save(starting);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    final active = starting.copyWith(status: SessionStatus.inProgress);
    final activeSaved = await _sessions.save(active);
    if (activeSaved.isError) return Result.error(activeSaved.errorOrNull!);
    _events.publish(WorkoutSessionStarted(aggregateId: id));
    return Result.success(active);
  }

  Future<Result<WorkoutSession, Failure>> pause(String id,
      {InterruptionReason reason = InterruptionReason.userPause}) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(
          ConflictFailure('Only an active session can be paused', id));
    }
    final now = AppClock.nowUtc();
    final restIntervals = session.restIntervals
        .map((rest) => rest.endedAt == null
            ? rest.copyWith(
                endedAt: now,
                actualDurationSeconds: now.difference(rest.startedAt).inSeconds,
              )
            : rest)
        .toList();
    final updated = session.copyWith(
      status: SessionStatus.paused,
      pausedAt: now,
      interruptions: [
        ...session.interruptions,
        SessionInterruption(
          id: UniqueId.generate().value,
          startedAt: now,
          reason: reason,
          userInitiated: reason == InterruptionReason.userPause,
        )
      ],
      restIntervals: restIntervals,
      audits: [...session.audits, _audit(id, AuditAction.paused)],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionPaused(aggregateId: id));
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> resume(String id) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.paused) {
      return Result.error(
          ConflictFailure('Only a paused session can be resumed', id));
    }
    final now = AppClock.nowUtc();
    final interruptions = [...session.interruptions];
    if (interruptions.isNotEmpty && interruptions.last.endedAt == null) {
      interruptions[interruptions.length - 1] =
          interruptions.last.copyWith(endedAt: now);
    }
    final updated = session.copyWith(
      status: SessionStatus.inProgress,
      pausedAt: null,
      interruptions: interruptions,
      audits: [...session.audits, _audit(id, AuditAction.resumed)],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionResumed(aggregateId: id));
    return Result.success(updated);
  }

  /// Records set measurements and appends an immutable audit record.
  Future<Result<WorkoutSession, Failure>> recordSet({
    required String sessionId,
    required String setId,
    double? weight,
    int? reps,
    int? durationSeconds,
    double? distanceMeters,
    int? calories,
    double? rpe,
    int? rir,
    String? actorId,
    String? reason,
  }) async {
    if ((weight != null && (!weight.isFinite || weight < 0)) ||
        (reps != null && reps < 0) ||
        (durationSeconds != null && durationSeconds < 0) ||
        (distanceMeters != null &&
            (!distanceMeters.isFinite || distanceMeters < 0)) ||
        (calories != null && calories < 0) ||
        (rpe != null && (!rpe.isFinite || rpe < 0 || rpe > 10)) ||
        (rir != null && rir < 0)) {
      return const Result.error(ValidationFailure(
          'Set measurements must be non-negative and RPE must be between 0 and 10'));
    }
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Sets can only be recorded in an active session', sessionId));
    }
    ExecutionSet? oldSet;
    final blocks = <SessionBlock>[];
    for (final block in session.blocks) {
      final items = <SessionItem>[];
      for (final item in block.items) {
        final sets = <ExecutionSet>[];
        for (final set in item.sets) {
          if (set.id != setId) {
            sets.add(set);
            continue;
          }
          oldSet = set;
          sets.add(set.copyWith(
            actualWeight: weight ?? set.actualWeight,
            actualReps: reps ?? set.actualReps,
            actualDurationSeconds: durationSeconds ?? set.actualDurationSeconds,
            actualDistanceMeters: distanceMeters ?? set.actualDistanceMeters,
            actualCalories: calories ?? set.actualCalories,
            rpe: rpe ?? set.rpe,
            rir: rir ?? set.rir,
            startedAt: set.startedAt ?? AppClock.nowUtc(),
            completedAt: AppClock.nowUtc(),
            status: ExecutionSetStatus.completed,
          ));
        }
        items.add(item.copyWith(sets: sets));
      }
      blocks.add(block.copyWith(items: items));
    }
    if (oldSet == null) {
      return Result.error(NotFoundFailure('Execution set not found', setId));
    }
    var updatedSet = oldSet;
    for (final block in blocks) {
      for (final item in block.items) {
        for (final set in item.sets) {
          if (set.id == setId) updatedSet = set;
        }
      }
    }
    final updated = session.copyWith(
      blocks: blocks,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'ExecutionSet',
            entityId: setId,
            actorId: actorId,
            previousValue: oldSet.toJson(),
            newValue: updatedSet.toJson(),
            reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events
        .publish(ExecutionSetCompleted(aggregateId: sessionId, setId: setId));
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> startRest({
    required String sessionId,
    required String executionSetId,
  }) async {
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Rest can only start during an active session', sessionId));
    }
    ExecutionSet? executionSet;
    for (final block in session.blocks) {
      for (final item in block.items) {
        for (final set in item.sets) {
          if (set.id == executionSetId) executionSet = set;
        }
      }
    }
    if (executionSet == null) {
      return Result.error(
          NotFoundFailure('Execution set not found', executionSetId));
    }
    if (executionSet.plannedRestSeconds <= 0) {
      return const Result.error(ValidationFailure(
          'This set does not have a positive planned rest duration'));
    }
    final minimumSeconds = executionSet.restMinimumSeconds ?? 0;
    final maximumSeconds = executionSet.restMaximumSeconds;
    if (executionSet.plannedRestSeconds < minimumSeconds ||
        (maximumSeconds != null &&
            executionSet.plannedRestSeconds > maximumSeconds)) {
      return Result.error(ValidationFailure(
          'Planned rest must be within the policy limits', executionSet.id));
    }
    if (session.restIntervals.any((rest) => rest.endedAt == null)) {
      return Result.error(
          ConflictFailure('A rest interval is already active', sessionId));
    }
    final rest = RestInterval(
      id: UniqueId.generate().value,
      executionSetId: executionSetId,
      startedAt: AppClock.nowUtc(),
      plannedDurationSeconds: executionSet.plannedRestSeconds,
      minimumDurationSeconds: minimumSeconds,
      maximumDurationSeconds: maximumSeconds,
      allowSkip: executionSet.restAllowSkip,
      allowExtend: executionSet.restAllowExtend,
    );
    final updated =
        session.copyWith(restIntervals: [...session.restIntervals, rest]);
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(RestStarted(aggregateId: sessionId));
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> extendRest(String sessionId,
      {String? restIntervalId, int extensionSeconds = 15}) async {
    if (extensionSeconds <= 0) {
      return const Result.error(
          ValidationFailure('Rest extension must be greater than zero'));
    }
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Rest can only be extended during an active session', sessionId));
    }
    final index = restIntervalId == null
        ? session.restIntervals.lastIndexWhere((rest) => rest.endedAt == null)
        : session.restIntervals.indexWhere(
            (rest) => rest.id == restIntervalId && rest.endedAt == null);
    if (index < 0) {
      return Result.error(NotFoundFailure(
          'Active rest interval not found', restIntervalId ?? sessionId));
    }
    final activeRest = session.restIntervals[index];
    if (!activeRest.allowExtend) {
      return Result.error(ConflictFailure(
          'This rest policy does not allow extensions', activeRest.id));
    }
    final requestedDuration =
        activeRest.plannedDurationSeconds + extensionSeconds;
    final extendedDuration = activeRest.maximumDurationSeconds != null &&
            requestedDuration > activeRest.maximumDurationSeconds!
        ? activeRest.maximumDurationSeconds!
        : requestedDuration;
    if (extendedDuration <= activeRest.plannedDurationSeconds) {
      return Result.error(ConflictFailure(
          'The maximum rest duration has been reached', activeRest.id));
    }
    final intervals = [...session.restIntervals];
    intervals[index] = activeRest.copyWith(
      plannedDurationSeconds: extendedDuration,
    );
    final updated = session.copyWith(
      restIntervals: intervals,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'RestInterval',
            entityId: activeRest.id,
            field: 'plannedDurationSeconds',
            previousValue: activeRest.plannedDurationSeconds,
            newValue: extendedDuration)
      ],
    );
    final saved = await _sessions.save(updated);
    return saved.isError
        ? Result.error(saved.errorOrNull!)
        : Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> skipRest(String sessionId,
      {String? restIntervalId}) async {
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Rest can only be skipped during an active session', sessionId));
    }
    final index = restIntervalId == null
        ? session.restIntervals.lastIndexWhere((rest) => rest.endedAt == null)
        : session.restIntervals.indexWhere(
            (rest) => rest.id == restIntervalId && rest.endedAt == null);
    if (index < 0) {
      return Result.error(NotFoundFailure(
          'Active rest interval not found', restIntervalId ?? sessionId));
    }
    final activeRest = session.restIntervals[index];
    if (!activeRest.allowSkip) {
      return Result.error(ConflictFailure(
          'This rest policy does not allow skipping', activeRest.id));
    }
    final now = AppClock.nowUtc();
    final elapsed = now.difference(activeRest.startedAt).inSeconds;
    if (elapsed < activeRest.minimumDurationSeconds) {
      return Result.error(
          ConflictFailure('Minimum rest time has not elapsed', activeRest.id));
    }
    final intervals = [...session.restIntervals];
    intervals[index] = activeRest.copyWith(
      endedAt: now,
      actualDurationSeconds: elapsed,
      skipped: true,
    );
    final updated = session.copyWith(
      restIntervals: intervals,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'RestInterval',
            entityId: activeRest.id,
            field: 'skipped',
            previousValue: false,
            newValue: true)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(
        RestSkipped(aggregateId: sessionId, restIntervalId: activeRest.id));
    return Result.success(updated);
  }

  /// Changes prescriptions on this session copy only; the source revision is
  /// never loaded for writing or mutated.
  Future<Result<WorkoutSession, Failure>> updateSetTarget({
    required String sessionId,
    required String setId,
    required double? weight,
    required int? reps,
    required int? durationSeconds,
    required double? distanceMeters,
    required int? calories,
    required double? rpe,
    required int? rir,
    required double? percentageOf1Rm,
    String? actorId,
    String? reason,
  }) async {
    if ((weight != null && (!weight.isFinite || weight < 0)) ||
        (reps != null && reps < 0) ||
        (durationSeconds != null && durationSeconds < 0) ||
        (distanceMeters != null &&
            (!distanceMeters.isFinite || distanceMeters < 0)) ||
        (calories != null && calories < 0) ||
        (rpe != null && (!rpe.isFinite || rpe < 0 || rpe > 10)) ||
        (rir != null && rir < 0) ||
        (percentageOf1Rm != null &&
            (!percentageOf1Rm.isFinite || percentageOf1Rm < 0))) {
      return const Result.error(ValidationFailure(
          'Targets must be non-negative and RPE must be between 0 and 10'));
    }
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress &&
        session.status != SessionStatus.paused) {
      return Result.error(ConflictFailure(
          'Targets can only be changed in an active session', sessionId));
    }
    ExecutionSet? oldSet;
    final blocks = session.blocks
        .map((block) => block.copyWith(
              items: block.items
                  .map((item) => item.copyWith(
                        sets: item.sets.map((set) {
                          if (set.id != setId) return set;
                          oldSet = set;
                          return set.copyWith(
                            targetWeight: weight,
                            targetReps: reps,
                            targetDurationSeconds: durationSeconds,
                            targetDistanceMeters: distanceMeters,
                            targetCalories: calories,
                            targetRpe: rpe,
                            targetRir: rir,
                            percentageOf1Rm: percentageOf1Rm,
                          );
                        }).toList(),
                      ))
                  .toList(),
            ))
        .toList();
    final previousSet = oldSet;
    if (previousSet == null) {
      return Result.error(NotFoundFailure('Execution set not found', setId));
    }
    var updatedSet = previousSet;
    for (final block in blocks) {
      for (final item in block.items) {
        for (final set in item.sets) {
          if (set.id == setId) updatedSet = set;
        }
      }
    }
    final updated = session.copyWith(
      blocks: blocks,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'ExecutionSet',
            entityId: setId,
            actorId: actorId,
            field: 'target',
            previousValue: previousSet.toJson(),
            newValue: updatedSet.toJson(),
            reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> finishRest(String sessionId,
      {String? restIntervalId}) async {
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Rest can only finish during an active session', sessionId));
    }
    final index = restIntervalId == null
        ? session.restIntervals.lastIndexWhere((rest) => rest.endedAt == null)
        : session.restIntervals.indexWhere(
            (rest) => rest.id == restIntervalId && rest.endedAt == null);
    if (index < 0) {
      return Result.error(NotFoundFailure(
          'Active rest interval not found', restIntervalId ?? sessionId));
    }
    final now = AppClock.nowUtc();
    final intervals = [...session.restIntervals];
    final activeRest = intervals[index];
    final elapsed = now.difference(activeRest.startedAt).inSeconds;
    if (elapsed < activeRest.minimumDurationSeconds) {
      return Result.error(
          ConflictFailure('Minimum rest time has not elapsed', activeRest.id));
    }
    final skipped = elapsed < activeRest.plannedDurationSeconds;
    if (skipped && !activeRest.allowSkip) {
      return Result.error(ConflictFailure(
          'This rest policy does not allow ending early', activeRest.id));
    }
    intervals[index] = activeRest.copyWith(
      endedAt: now,
      actualDurationSeconds: elapsed,
      skipped: skipped,
    );
    final updated = session.copyWith(
      restIntervals: intervals,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'RestInterval',
            entityId: activeRest.id,
            previousValue: activeRest.toJson(),
            newValue: intervals[index].toJson())
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    if (skipped) {
      _events.publish(
          RestSkipped(aggregateId: sessionId, restIntervalId: activeRest.id));
    } else {
      _events.publish(RestCompleted(aggregateId: sessionId));
    }
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> skipSet({
    required String sessionId,
    required String setId,
    String? actorId,
    String? reason,
  }) {
    return _changeSetStatus(sessionId, setId, ExecutionSetStatus.skipped,
        actorId: actorId, reason: reason);
  }

  Future<Result<WorkoutSession, Failure>> deleteSet({
    required String sessionId,
    required String setId,
    String? actorId,
    String? reason,
  }) async {
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Sets can only be deleted in an active session', sessionId));
    }
    ExecutionSet? removed;
    final blocks = session.blocks
        .map((block) => block.copyWith(
                items: block.items.map((item) {
              final sets = item.sets.where((set) {
                if (set.id == setId) removed = set;
                return set.id != setId;
              }).toList();
              return item.copyWith(sets: sets);
            }).toList()))
        .toList();
    final removedSet = removed;
    if (removedSet == null) {
      return Result.error(NotFoundFailure('Execution set not found', setId));
    }
    final relatedRestIntervals = session.restIntervals
        .where((rest) => rest.executionSetId == setId)
        .toList();
    if (relatedRestIntervals.any((rest) => rest.endedAt == null)) {
      return Result.error(ConflictFailure(
          'Finish the active rest interval before deleting this set', setId));
    }
    final updated = session.copyWith(
      blocks: blocks,
      restIntervals: session.restIntervals
          .where((rest) => rest.executionSetId != setId)
          .toList(),
      audits: [
        ...session.audits,
        ...relatedRestIntervals.map((rest) => _audit(
              sessionId,
              AuditAction.deleted,
              entityType: 'RestInterval',
              entityId: rest.id,
              actorId: actorId,
              previousValue: rest.toJson(),
              reason: 'Parent execution set deleted',
            )),
        _audit(sessionId, AuditAction.deleted,
            entityType: 'ExecutionSet',
            entityId: setId,
            actorId: actorId,
            previousValue: removedSet.toJson(),
            reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(ExecutionSetDeleted(aggregateId: sessionId, setId: setId));
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> _changeSetStatus(
    String sessionId,
    String setId,
    ExecutionSetStatus status, {
    String? actorId,
    String? reason,
  }) async {
    final found = await _get(sessionId);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress) {
      return Result.error(ConflictFailure(
          'Sets can only be changed in an active session', sessionId));
    }
    ExecutionSet? oldSet;
    final blocks = session.blocks
        .map((block) => block.copyWith(
            items: block.items
                .map((item) => item.copyWith(
                        sets: item.sets.map((set) {
                      if (set.id != setId) return set;
                      oldSet = set;
                      return set.copyWith(
                          status: status,
                          completedAt: status == ExecutionSetStatus.skipped
                              ? AppClock.nowUtc()
                              : set.completedAt);
                    }).toList()))
                .toList()))
        .toList();
    final previousSet = oldSet;
    if (previousSet == null) {
      return Result.error(NotFoundFailure('Execution set not found', setId));
    }
    final updated = session.copyWith(
      blocks: blocks,
      audits: [
        ...session.audits,
        _audit(sessionId, AuditAction.updated,
            entityType: 'ExecutionSet',
            entityId: setId,
            actorId: actorId,
            previousValue: previousSet.toJson(),
            newValue: {'status': status.name},
            reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    if (status == ExecutionSetStatus.skipped) {
      _events
          .publish(ExecutionSetSkipped(aggregateId: sessionId, setId: setId));
    }
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> complete(String id) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress &&
        session.status != SessionStatus.paused) {
      return Result.error(ConflictFailure(
          'Only an active or paused session can be completed', id));
    }
    final now = AppClock.nowUtc();
    final restIntervals = session.restIntervals
        .map((rest) => rest.endedAt == null
            ? rest.copyWith(
                endedAt: now,
                actualDurationSeconds: now.difference(rest.startedAt).inSeconds,
              )
            : rest)
        .toList();
    final interruptions = [...session.interruptions];
    if (interruptions.isNotEmpty && interruptions.last.endedAt == null) {
      interruptions[interruptions.length - 1] =
          interruptions.last.copyWith(endedAt: now);
    }
    final completing = session.copyWith(status: SessionStatus.completing);
    final prepared = await _sessions.save(completing);
    if (prepared.isError) return Result.error(prepared.errorOrNull!);
    final completed = completing.copyWith(
      status: SessionStatus.completed,
      completedAt: now,
      interruptions: interruptions,
      restIntervals: restIntervals,
      audits: [...session.audits, _audit(id, AuditAction.completed)],
    );
    final saved = await _sessions.save(completed);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionCompleted(aggregateId: id));
    return Result.success(completed);
  }

  Future<Result<WorkoutSession, Failure>> cancel(String id,
      {String? reason}) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.draft &&
        session.status != SessionStatus.starting &&
        session.status != SessionStatus.inProgress &&
        session.status != SessionStatus.paused) {
      return Result.error(ConflictFailure(
          'This session cannot be cancelled from its current state', id));
    }
    final now = AppClock.nowUtc();
    final updated = session.copyWith(
      status: SessionStatus.cancelled,
      interruptions: _closeInterruptions(session, now),
      restIntervals: _closeRestIntervals(session, now),
      audits: [
        ...session.audits,
        _audit(id, AuditAction.cancelled, reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionCancelled(aggregateId: id));
    return Result.success(updated);
  }

  Future<Result<WorkoutSession, Failure>> abandon(String id,
      {String? reason}) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.inProgress &&
        session.status != SessionStatus.paused) {
      return Result.error(ConflictFailure(
          'Only an active or paused session can be abandoned', id));
    }
    final now = AppClock.nowUtc();
    final updated = session.copyWith(
      status: SessionStatus.abandoned,
      interruptions: _closeInterruptions(session, now),
      restIntervals: _closeRestIntervals(session, now),
      audits: [
        ...session.audits,
        _audit(id, AuditAction.abandoned, reason: reason)
      ],
    );
    final saved = await _sessions.save(updated);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionAbandoned(aggregateId: id));
    return Result.success(updated);
  }

  Future<Result<List<WorkoutSession>, Failure>> recoverable(String userId) =>
      _sessions.listUnfinished(userId);

  /// Moves a process-interrupted STARTING session to PAUSED and records the
  /// cold-start gap as an application interruption for duration accounting.
  Future<Result<WorkoutSession, Failure>> recoverStarting(String id) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status != SessionStatus.starting) {
      return Result.error(ConflictFailure(
          'Only a starting session can be recovered this way', id));
    }
    final now = AppClock.nowUtc();
    final interruption = SessionInterruption(
      id: UniqueId.generate().value,
      startedAt: session.startedAt ?? now,
      endedAt: now,
      reason: InterruptionReason.applicationBackground,
      userInitiated: false,
    );
    final updated = session.copyWith(
      status: SessionStatus.paused,
      pausedAt: now,
      interruptions: [...session.interruptions, interruption],
      audits: [
        ...session.audits,
        _audit(id, AuditAction.paused,
            actorType: AuditActorType.system,
            reason: 'Recovered after an application interruption')
      ],
    );
    final saved = await _sessions.save(updated);
    return saved.isError
        ? Result.error(saved.errorOrNull!)
        : Result.success(updated);
  }

  /// Repairs transitions that were interrupted between their durable writes.
  Future<Result<WorkoutSession, Failure>> recoverIncomplete(String id) async {
    final found = await _get(id);
    if (found.isError) return found;
    final session = found.dataOrNull!;
    if (session.status == SessionStatus.starting) {
      return recoverStarting(id);
    }
    if (session.status != SessionStatus.completing) {
      return Result.success(session);
    }
    final now = AppClock.nowUtc();
    final restIntervals = session.restIntervals
        .map((rest) => rest.endedAt == null
            ? rest.copyWith(
                endedAt: now,
                actualDurationSeconds: now.difference(rest.startedAt).inSeconds,
              )
            : rest)
        .toList();
    final completed = session.copyWith(
      status: SessionStatus.completed,
      completedAt: now,
      restIntervals: restIntervals,
      audits: [
        ...session.audits,
        _audit(id, AuditAction.completed,
            actorType: AuditActorType.system,
            reason: 'Completion finalized during recovery')
      ],
    );
    final saved = await _sessions.save(completed);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    _events.publish(WorkoutSessionCompleted(aggregateId: id));
    return Result.success(completed);
  }

  Future<Result<WorkoutSession, Failure>> _get(String id) =>
      _sessions.getById(id);

  List<SessionInterruption> _closeInterruptions(
      WorkoutSession session, DateTime at) {
    return session.interruptions
        .map((interruption) => interruption.endedAt == null
            ? interruption.copyWith(endedAt: at)
            : interruption)
        .toList();
  }

  List<RestInterval> _closeRestIntervals(WorkoutSession session, DateTime at) {
    return session.restIntervals
        .map((rest) => rest.endedAt == null
            ? rest.copyWith(
                endedAt: at,
                actualDurationSeconds: at.difference(rest.startedAt).inSeconds,
              )
            : rest)
        .toList();
  }

  WorkoutSession _cloneRevision(WorkoutTemplateRevision revision,
      WorkoutTemplate template, String userId) {
    final blocks = revision.blocks
        .map((block) => SessionBlock(
              id: UniqueId.generate().value,
              sourceTemplateBlockId: block.id,
              name: block.name,
              type: block.type,
              rounds: block.rounds,
              timeCapSeconds: block.timeCapSeconds,
              transitionSeconds: block.transitionSeconds,
              notes: block.notes,
              items: block.items
                  .map((item) => SessionItem(
                        id: UniqueId.generate().value,
                        sourceTemplateItemId: item.id,
                        exerciseId: item.exerciseId,
                        order: item.order,
                        notes: item.coachNotes,
                        sets: item.targetSets
                            .map((target) => ExecutionSet(
                                  id: UniqueId.generate().value,
                                  setNumber: target.setNumber,
                                  setType: target.setType,
                                  targetWeight: target.targetWeight,
                                  targetReps: target.targetReps,
                                  targetDurationSeconds:
                                      target.targetDurationSeconds,
                                  targetDistanceMeters:
                                      target.targetDistanceMeters,
                                  targetCalories: target.targetCalories,
                                  targetRpe: target.targetRpe,
                                  targetRir: target.targetRir,
                                  percentageOf1Rm: target.percentageOf1Rm,
                                  plannedRestSeconds:
                                      target.restPolicy?.targetSeconds ?? 0,
                                  restAutoStart:
                                      target.restPolicy?.autoStart ?? false,
                                  restAllowSkip:
                                      target.restPolicy?.allowSkip ?? true,
                                  restAllowExtend:
                                      target.restPolicy?.allowExtend ?? true,
                                  restMinimumSeconds:
                                      target.restPolicy?.minimumSeconds,
                                  restMaximumSeconds:
                                      target.restPolicy?.maximumSeconds,
                                  notes: target.notes,
                                ))
                            .toList(),
                      ))
                  .toList(),
            ))
        .toList();
    final id = UniqueId.generate().value;
    final now = AppClock.nowUtc();
    return WorkoutSession(
      id: id,
      userId: userId,
      templateId: template.id,
      templateRevisionId: revision.id,
      templateName: template.name,
      createdAt: now,
      blocks: blocks,
      audits: [_audit(id, AuditAction.created, actorId: userId)],
    );
  }

  AuditEntry _audit(
    String sessionId,
    AuditAction action, {
    String entityType = 'WorkoutSession',
    String? entityId,
    AuditActorType actorType = AuditActorType.user,
    String? field,
    String? actorId,
    Object? previousValue,
    Object? newValue,
    String? reason,
  }) =>
      AuditEntry(
        id: UniqueId.generate().value,
        timestamp: AppClock.nowUtc(),
        actorType: actorType,
        action: action,
        actorId: actorId,
        entityType: entityType,
        entityId: entityId ?? sessionId,
        field: field,
        previousValue: previousValue,
        newValue: newValue,
        reason: reason,
      );
}
