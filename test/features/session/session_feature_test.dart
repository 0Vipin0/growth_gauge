// ignore_for_file: unnecessary_type_name_in_constructor, use_primary_constructors

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/core/error/result.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/domain/execution_set.dart';
import 'package:growth_gauge/features/session/domain/session_enums.dart';
import 'package:growth_gauge/features/session/domain/session_events.dart';
import 'package:growth_gauge/features/session/domain/session_interval.dart';
import 'package:growth_gauge/features/session/domain/workout_session.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/template/application/template_use_cases.dart';
import 'package:growth_gauge/features/template/domain/rest_policy.dart';
import 'package:growth_gauge/features/template/domain/target_set.dart';
import 'package:growth_gauge/features/template/domain/template_item.dart';
import 'package:growth_gauge/features/template/domain/workout_block.dart';
import 'package:growth_gauge/features/template/domain/workout_template.dart';
import 'package:growth_gauge/features/template/domain/workout_template_revision.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';

void main() {
  group('Session feature', () {
    late AppDatabase database;
    late TemplateRepository templateRepository;
    late WorkoutSessionRepository sessionRepository;
    late TemplateUseCases templateUseCases;
    late DomainEventDispatcher events;
    late SessionUseCases sessionUseCases;

    setUp(() {
      database = AppDatabase.inMemory();
      templateRepository = TemplateRepository(database);
      sessionRepository = WorkoutSessionRepository(database);
      templateUseCases = TemplateUseCases(templateRepository);
      events = DomainEventDispatcher();
      sessionUseCases = SessionUseCases(
        templates: templateRepository,
        sessions: sessionRepository,
        events: events,
      );
    });

    tearDown(() async {
      await events.dispose();
      await database.close();
    });

    Future<WorkoutSession> createSession({
      String userId = 'user-1',
      RestPolicy? restPolicy,
      bool start = true,
    }) => _createSession(
      templateUseCases,
      templateRepository,
      sessionUseCases,
      userId: userId,
      restPolicy: restPolicy,
      start: start,
    );

    test('only published revisions can be copied into a session', () async {
      final fixture = await _createTemplate(
        templateUseCases,
        templateRepository,
        restPolicy: null,
      );

      final draftResult = await sessionUseCases.createFromRevision(
        revisionId: fixture.revision.id,
        userId: 'user-1',
      );
      expect(draftResult.errorOrNull, isA<ConflictFailure>());

      await templateUseCases.publish(fixture.revision.id);
      final created = await sessionUseCases.createFromRevision(
        revisionId: fixture.revision.id,
        userId: 'user-1',
      );
      final session = created.dataOrNull!;
      final source = (await templateRepository.getRevision(fixture.revision.id))
          .dataOrNull!;
      final sourceSet = source.blocks.single.items.single.targetSets.single;
      final sessionSet = _onlySet(session);
      final persisted = (await sessionRepository.getById(session.id))
          .dataOrNull!;

      expect(created.isSuccess, isTrue);
      expect(session.status, SessionStatus.draft);
      expect(session.templateRevisionId, fixture.revision.id);
      expect(sessionSet.id, isNot(sourceSet.id));
      expect(sessionSet.sourceTemplateSetId, sourceSet.id);
      expect(_onlySet(persisted).sourceTemplateSetId, sourceSet.id);
    });

    test(
      'target edits affect only the session snapshot and append an audit',
      () async {
        final session = await createSession();
        final set = _onlySet(session);

        final result = await sessionUseCases.updateSetTarget(
          sessionId: session.id,
          setId: set.id,
          weight: 110,
          reps: 6,
          durationSeconds: set.targetDurationSeconds,
          distanceMeters: set.targetDistanceMeters,
          calories: set.targetCalories,
          rpe: set.targetRpe,
          rir: set.targetRir,
          percentageOf1Rm: set.percentageOf1Rm,
        );
        final source = (await templateRepository.getRevision(
          session.templateRevisionId,
        )).dataOrNull!;

        expect(result.isSuccess, isTrue);
        expect(_onlySet(result.dataOrNull!).targetWeight, 110);
        expect(
          source.blocks.single.items.single.targetSets.single.targetWeight,
          100,
        );
        expect(result.dataOrNull!.audits.last.entityType, 'ExecutionSet');
        expect(result.dataOrNull!.audits.last.field, 'target');
      },
    );

    test('set logging validates measurements, blocks duplicate completion, and emits after save', () async {
      final session = await createSession();
      final setId = _onlySet(session).id;
      final completedEvents = <ExecutionSetCompleted>[];
      final subscription = events.subscribe<ExecutionSetCompleted>(
        completedEvents.add,
      );

      final empty = await sessionUseCases.recordSet(
        sessionId: session.id,
        setId: setId,
      );
      expect(empty.errorOrNull, isA<ValidationFailure>());

      final recorded = await sessionUseCases.recordSet(
        sessionId: session.id,
        setId: setId,
        weight: 100,
        reps: 8,
      );
      final duplicate = await sessionUseCases.recordSet(
        sessionId: session.id,
        setId: setId,
        reps: 8,
      );
      await Future<void>.delayed(Duration.zero);
      final persisted = (await sessionRepository.getById(session.id))
          .dataOrNull!;

      expect(recorded.isSuccess, isTrue);
      expect(duplicate.errorOrNull, isA<ConflictFailure>());
      expect(_onlySet(persisted).status, ExecutionSetStatus.completed);
      expect(persisted.audits.last.entityId, setId);
      expect(completedEvents.map((event) => event.setId), [setId]);
      await subscription.cancel();
    });

    test(
      'skipping a set records the state and rejects a repeated skip',
      () async {
        final session = await createSession();
        final setId = _onlySet(session).id;
        final skippedEvents = <ExecutionSetSkipped>[];
        final subscription = events.subscribe<ExecutionSetSkipped>(
          skippedEvents.add,
        );

        final skipped = await sessionUseCases.skipSet(
          sessionId: session.id,
          setId: setId,
          reason: 'Equipment unavailable',
        );
        final repeated = await sessionUseCases.skipSet(
          sessionId: session.id,
          setId: setId,
        );
        await Future<void>.delayed(Duration.zero);

        expect(
          _onlySet(skipped.dataOrNull!).status,
          ExecutionSetStatus.skipped,
        );
        expect(skipped.dataOrNull!.audits.last.reason, 'Equipment unavailable');
        expect(repeated.errorOrNull, isA<ConflictFailure>());
        expect(skippedEvents.map((event) => event.setId), [setId]);
        await subscription.cancel();
      },
    );

    test(
      'cannot delete a set during rest and removes its finished rest history',
      () async {
        final session = await createSession(
          restPolicy: const RestPolicy(
            id: 'deletion-rest-policy',
            targetSeconds: 20,
            minimumSeconds: 0,
            autoStart: false,
          ),
        );
        final setId = _onlySet(session).id;
        await sessionUseCases.recordSet(
          sessionId: session.id,
          setId: setId,
          reps: 8,
        );
        final rest = (await sessionUseCases.startRest(
          sessionId: session.id,
          executionSetId: setId,
        )).dataOrNull!.restIntervals.single;

        final activeRestDelete = await sessionUseCases.deleteSet(
          sessionId: session.id,
          setId: setId,
        );
        expect(activeRestDelete.errorOrNull, isA<ConflictFailure>());

        await sessionUseCases.finishRest(session.id, restIntervalId: rest.id);
        final deleted = await sessionUseCases.deleteSet(
          sessionId: session.id,
          setId: setId,
          reason: 'Remove mistaken set',
        );

        expect(deleted.isSuccess, isTrue);
        expect(deleted.dataOrNull!.blocks.single.items.single.sets, isEmpty);
        expect(deleted.dataOrNull!.restIntervals, isEmpty);
        expect(
          deleted.dataOrNull!.audits.where(
            (entry) =>
                entry.entityType == 'RestInterval' &&
                entry.action == AuditAction.deleted,
          ),
          hasLength(1),
        );
        expect(deleted.dataOrNull!.audits.last.reason, 'Remove mistaken set');
      },
    );

    test(
      'pause and resume exclude application interruption from active time',
      () async {
        var now = DateTime.utc(2026, 9, 26, 10);
        await withClock(Clock(() => now), () async {
          final session = await createSession();
          now = now.add(const Duration(seconds: 30));
          final paused = await sessionUseCases.pause(
            session.id,
            reason: InterruptionReason.applicationBackground,
          );
          now = now.add(const Duration(seconds: 60));
          expect(paused.dataOrNull!.elapsedActiveSecondsAt(now), 30);

          final resumed = await sessionUseCases.resume(session.id);
          now = now.add(const Duration(seconds: 15));

          expect(resumed.dataOrNull!.status, SessionStatus.inProgress);
          expect(
            resumed.dataOrNull!.interruptions.single.endedAt,
            now.subtract(const Duration(seconds: 15)),
          );
          expect(resumed.dataOrNull!.elapsedActiveSecondsAt(now), 45);
        });
      },
    );

    test('rest policy enforces minimums, records audits, and totals repeated intervals', () async {
      var now = DateTime.utc(2026, 9, 26, 11);
      await withClock(Clock(() => now), () async {
        final session = await createSession(
          restPolicy: const RestPolicy(
            id: 'rest-policy',
            targetSeconds: 20,
            minimumSeconds: 5,
            maximumSeconds: 24,
            autoStart: false,
          ),
        );
        final setId = _onlySet(session).id;
        final beforeCompletion = await sessionUseCases.startRest(
          sessionId: session.id,
          executionSetId: setId,
        );
        expect(beforeCompletion.errorOrNull, isA<ConflictFailure>());

        await sessionUseCases.recordSet(
          sessionId: session.id,
          setId: setId,
          reps: 8,
        );
        final firstRest = await sessionUseCases.startRest(
          sessionId: session.id,
          executionSetId: setId,
        );
        final firstIntervalId = firstRest.dataOrNull!.restIntervals.single.id;
        now = now.add(const Duration(seconds: 4));
        final tooEarly = await sessionUseCases.skipRest(
          session.id,
          restIntervalId: firstIntervalId,
        );
        expect(tooEarly.errorOrNull, isA<ConflictFailure>());

        now = now.add(const Duration(seconds: 1));
        final skipped = await sessionUseCases.skipRest(
          session.id,
          restIntervalId: firstIntervalId,
        );
        expect(skipped.isSuccess, isTrue);
        expect(_onlySet(skipped.dataOrNull!).actualRestSeconds, 5);
        expect(
          skipped.dataOrNull!.audits.last.previousValue,
          isA<Map<String, dynamic>>(),
        );

        final secondRest = await sessionUseCases.startRest(
          sessionId: session.id,
          executionSetId: setId,
        );
        final secondIntervalId = secondRest.dataOrNull!.restIntervals.last.id;
        final extended = await sessionUseCases.extendRest(
          session.id,
          restIntervalId: secondIntervalId,
        );
        expect(
          extended.dataOrNull!.restIntervals.last.plannedDurationSeconds,
          24,
        );
        final maxed = await sessionUseCases.extendRest(
          session.id,
          restIntervalId: secondIntervalId,
          extensionSeconds: 1,
        );
        expect(maxed.errorOrNull, isA<ConflictFailure>());

        now = now.add(const Duration(seconds: 24));
        final finished = await sessionUseCases.finishRest(
          session.id,
          restIntervalId: secondIntervalId,
        );
        expect(finished.isSuccess, isTrue);
        expect(_onlySet(finished.dataOrNull!).actualRestSeconds, 29);
        expect(finished.dataOrNull!.restIntervals.last.skipped, isFalse);
        expect(
          finished.dataOrNull!.audits.where(
            (entry) => entry.entityType == 'RestInterval',
          ),
          isNotEmpty,
        );
      });
    });

    test(
      'completion recovery keeps the durable completion time and rest total',
      () async {
        var now = DateTime.utc(2026, 9, 26, 12);
        await withClock(Clock(() => now), () async {
          final session = await createSession(
            restPolicy: const RestPolicy(
              id: 'rest-policy',
              targetSeconds: 30,
              minimumSeconds: 0,
              autoStart: false,
            ),
          );
          final setId = _onlySet(session).id;
          await sessionUseCases.recordSet(
            sessionId: session.id,
            setId: setId,
            reps: 8,
          );
          await sessionUseCases.startRest(
            sessionId: session.id,
            executionSetId: setId,
          );
          now = now.add(const Duration(seconds: 10));

          final failFinalSave = _FailCompletedSaveOnce(sessionRepository);
          final recoveryUseCases = SessionUseCases(
            templates: templateRepository,
            sessions: failFinalSave,
            events: events,
          );
          final interruptedCompletion = await recoveryUseCases.complete(
            session.id,
          );
          expect(interruptedCompletion.errorOrNull, isA<DatabaseFailure>());
          final completing = (await sessionRepository.getById(session.id))
              .dataOrNull!;
          final intendedCompletionTime = completing.completedAt!;
          expect(completing.status, SessionStatus.completing);
          expect(
            completing.restIntervals.single.endedAt,
            intendedCompletionTime,
          );

          now = now.add(const Duration(hours: 2));
          final recovered = await recoveryUseCases.recoverIncomplete(
            session.id,
          );
          final completed = recovered.dataOrNull!;

          expect(recovered.isSuccess, isTrue);
          expect(completed.status, SessionStatus.completed);
          expect(completed.completedAt, intendedCompletionTime);
          expect(completed.restIntervals.single.actualDurationSeconds, 10);
          expect(_onlySet(completed).actualRestSeconds, 10);
          expect(
            completed.audits.where(
              (entry) => entry.action == AuditAction.completed,
            ),
            hasLength(1),
          );
        });
      },
    );

    test(
      'recovery query is user scoped and repairs interrupted starts',
      () async {
        var now = DateTime.utc(2026, 9, 26, 13);
        await withClock(Clock(() => now), () async {
          final draft = await createSession(start: false);
          final active = await createSession();
          await createSession(userId: 'user-2');
          final unfinished = await sessionRepository.listUnfinished('user-1');

          expect(unfinished.dataOrNull!.map((entry) => entry.id), [active.id]);

          final starting = draft.copyWith(
            status: SessionStatus.starting,
            startedAt: now.subtract(const Duration(seconds: 3)),
          );
          await sessionRepository.save(starting);
          now = now.add(const Duration(minutes: 5));
          final recovered = await sessionUseCases.recoverIncomplete(draft.id);

          expect(recovered.dataOrNull!.status, SessionStatus.paused);
          expect(
            recovered.dataOrNull!.interruptions.single.reason,
            InterruptionReason.applicationBackground,
          );
          expect(recovered.dataOrNull!.interruptions.single.endedAt, now);
        });
      },
    );

    test(
      'cancel and abandon preserve terminal status and leave recovery list',
      () async {
        var now = DateTime.utc(2026, 9, 26, 14);
        await withClock(Clock(() => now), () async {
          const policy = RestPolicy(
            id: 'rest-policy',
            targetSeconds: 30,
            autoStart: false,
          );
          final cancelledSession = await createSession(restPolicy: policy);
          final cancelledSetId = _onlySet(cancelledSession).id;
          await sessionUseCases.recordSet(
            sessionId: cancelledSession.id,
            setId: cancelledSetId,
            reps: 8,
          );
          await sessionUseCases.startRest(
            sessionId: cancelledSession.id,
            executionSetId: cancelledSetId,
          );
          now = now.add(const Duration(seconds: 7));
          final cancelled = await sessionUseCases.cancel(cancelledSession.id);

          final abandonedSession = await createSession(restPolicy: policy);
          final abandonedSetId = _onlySet(abandonedSession).id;
          await sessionUseCases.recordSet(
            sessionId: abandonedSession.id,
            setId: abandonedSetId,
            reps: 8,
          );
          await sessionUseCases.startRest(
            sessionId: abandonedSession.id,
            executionSetId: abandonedSetId,
          );
          now = now.add(const Duration(seconds: 5));
          final abandoned = await sessionUseCases.abandon(abandonedSession.id);
          final recoverable = await sessionRepository.listUnfinished('user-1');

          expect(cancelled.dataOrNull!.status, SessionStatus.cancelled);
          expect(abandoned.dataOrNull!.status, SessionStatus.abandoned);
          expect(recoverable.dataOrNull, isEmpty);
          expect(
            cancelled.dataOrNull!.audits.last.action,
            AuditAction.cancelled,
          );
          expect(
            abandoned.dataOrNull!.audits.last.action,
            AuditAction.abandoned,
          );
          expect(_onlySet(cancelled.dataOrNull!).actualRestSeconds, 7);
          expect(_onlySet(abandoned.dataOrNull!).actualRestSeconds, 5);
        });
      },
    );

    test('completed session cannot be completed a second time', () async {
      final session = await createSession();

      final completed = await sessionUseCases.complete(session.id);
      final repeated = await sessionUseCases.complete(session.id);
      final persisted = (await sessionRepository.getById(session.id))
          .dataOrNull!;

      expect(completed.dataOrNull!.status, SessionStatus.completed);
      expect(repeated.errorOrNull, isA<ConflictFailure>());
      expect(persisted.status, SessionStatus.completed);
    });

    test(
      'completed session log persists RPE, mood, notes, and audit',
      () async {
        final session = await createSession();
        final premature = await sessionUseCases.saveSessionLog(
          id: session.id,
          perceivedEffort: 8,
          mood: SessionMood.good,
          notes: '  Strong session  ',
        );
        expect(premature.errorOrNull, isA<ConflictFailure>());

        await sessionUseCases.complete(session.id);
        final saved = await sessionUseCases.saveSessionLog(
          id: session.id,
          perceivedEffort: 8,
          mood: SessionMood.good,
          notes: '  Strong session  ',
        );
        final persisted = (await sessionRepository.getById(session.id))
            .dataOrNull!;
        final roundTripped = WorkoutSession.fromJson(
          jsonDecode(jsonEncode(persisted.toJson())) as Map<String, dynamic>,
        );

        expect(saved.isSuccess, isTrue);
        expect(persisted.sessionRpe, 8);
        expect(persisted.sessionMood, SessionMood.good);
        expect(persisted.sessionNotes, 'Strong session');
        expect(persisted.audits.last.field, 'sessionLog');
        expect(roundTripped.sessionMood, SessionMood.good);
        expect(roundTripped.sessionRpe, 8);
        expect(roundTripped.sessionNotes, 'Strong session');

        final invalidRpe = await sessionUseCases.saveSessionLog(
          id: session.id,
          perceivedEffort: 11,
          mood: SessionMood.good,
          notes: '',
        );
        expect(invalidRpe.errorOrNull, isA<ValidationFailure>());
      },
    );

    test(
      'interval sequence persists phase transitions and pause time',
      () async {
        var now = DateTime.utc(2026, 9, 26, 16);
        await withClock(Clock(() => now), () async {
          final session = await createSession();
          final started = await sessionUseCases.startIntervalSequence(
            sessionId: session.id,
            workSeconds: 5,
            restSeconds: 2,
            rounds: 2,
            cooldownSeconds: 3,
          );
          expect(started.isSuccess, isTrue);
          expect(
            started.dataOrNull!.sessionIntervals.map((entry) => entry.phase),
            [
              SessionIntervalPhase.work,
              SessionIntervalPhase.rest,
              SessionIntervalPhase.work,
              SessionIntervalPhase.cooldown,
            ],
          );

          now = now.add(const Duration(seconds: 3));
          final checkpoint = await sessionUseCases.checkpointActiveInterval(
            session.id,
          );
          final paused = await sessionUseCases.pause(session.id);
          expect(
            paused.dataOrNull!.sessionIntervals.first.status,
            SessionIntervalStatus.paused,
          );
          expect(paused.dataOrNull!.sessionIntervals.first.elapsedSeconds, 3);
          expect(checkpoint.isSuccess, isTrue);

          now = now.add(const Duration(seconds: 20));
          final resumed = await sessionUseCases.resume(session.id);
          expect(
            resumed.dataOrNull!.sessionIntervals.first.status,
            SessionIntervalStatus.active,
          );
          expect(resumed.dataOrNull!.sessionIntervals.first.elapsedAt(now), 3);

          final extended = await sessionUseCases.extendActiveInterval(
            session.id,
            extensionSeconds: 2,
          );
          expect(
            extended.dataOrNull!.sessionIntervals.first.durationSeconds,
            7,
          );

          final skipped = await sessionUseCases.advanceInterval(
            session.id,
            skipped: true,
          );
          expect(
            skipped.dataOrNull!.sessionIntervals.first.status,
            SessionIntervalStatus.skipped,
          );
          expect(
            skipped.dataOrNull!.sessionIntervals[1].status,
            SessionIntervalStatus.active,
          );

          await sessionUseCases.advanceInterval(session.id);
          now = now.add(const Duration(seconds: 5));
          final workDone = await sessionUseCases.advanceInterval(session.id);
          expect(
            workDone.dataOrNull!.sessionIntervals[2].status,
            SessionIntervalStatus.completed,
          );
          now = now.add(const Duration(seconds: 3));
          final completed = await sessionUseCases.advanceInterval(session.id);
          expect(
            completed.dataOrNull!.sessionIntervals.last.status,
            SessionIntervalStatus.completed,
          );
          final persisted = (await sessionRepository.getById(session.id))
              .dataOrNull!;
          expect(persisted.sessionIntervals, hasLength(4));
          expect(
            persisted.audits.where(
              (entry) => entry.entityType == 'SessionInterval',
            ),
            isNotEmpty,
          );
        });
      },
    );

    test(
      'cold recovery pauses interval at its latest durable checkpoint',
      () async {
        var now = DateTime.utc(2026, 9, 26, 17);
        await withClock(Clock(() => now), () async {
          final session = await createSession();
          await sessionUseCases.startIntervalSequence(
            sessionId: session.id,
            workSeconds: 20,
            restSeconds: 5,
            rounds: 2,
            cooldownSeconds: 0,
          );
          now = now.add(const Duration(seconds: 3));
          await sessionUseCases.checkpointActiveInterval(session.id);
          now = now.add(const Duration(minutes: 2));

          final recovered = await sessionUseCases.recoverIncomplete(session.id);
          final activeInterval = recovered.dataOrNull!.sessionIntervals.first;
          expect(recovered.dataOrNull!.status, SessionStatus.paused);
          expect(activeInterval.status, SessionIntervalStatus.paused);
          expect(activeInterval.elapsedSeconds, 3);
          expect(activeInterval.remainingAt(now), 17);

          now = now.add(const Duration(minutes: 1));
          final resumed = await sessionUseCases.resume(session.id);
          expect(resumed.dataOrNull!.sessionIntervals.first.elapsedAt(now), 3);
        });
      },
    );
  });
}

ExecutionSet _onlySet(WorkoutSession session) =>
    session.blocks.single.items.single.sets.single;

Future<WorkoutSession> _createSession(
  TemplateUseCases templateUseCases,
  TemplateRepository templateRepository,
  SessionUseCases sessionUseCases, {
  String userId = 'user-1',
  RestPolicy? restPolicy,
  bool start = true,
}) async {
  final fixture = await _createTemplate(
    templateUseCases,
    templateRepository,
    restPolicy: restPolicy,
  );
  await templateUseCases.publish(fixture.revision.id);
  final created = await sessionUseCases.createFromRevision(
    revisionId: fixture.revision.id,
    userId: userId,
  );
  if (!start) return created.dataOrNull!;
  final started = await sessionUseCases.start(created.dataOrNull!.id);
  return started.dataOrNull!;
}

Future<({WorkoutTemplate template, WorkoutTemplateRevision revision})>
_createTemplate(
  TemplateUseCases templateUseCases,
  TemplateRepository templateRepository, {
  required RestPolicy? restPolicy,
}) async {
  final created = await templateUseCases.create(
    name: 'Session test template',
    createdById: 'template-owner',
  );
  final template = created.dataOrNull!;
  final revision = (await templateRepository.getRevision(
    template.currentRevisionId!,
  )).dataOrNull!;
  await templateUseCases.updateDraftBlocks(revision.id, [
    WorkoutBlock(
      id: 'block-template',
      name: 'Main work',
      items: [
        TemplateItem(
          id: 'item-template',
          exerciseId: 'exercise-squat',
          order: 0,
          targetSets: [
            TargetSet(
              id: 'target-set',
              setNumber: 1,
              targetWeight: 100,
              targetReps: 8,
              restPolicy: restPolicy,
            ),
          ],
        ),
      ],
    ),
  ]);
  return (template: template, revision: revision);
}

class _FailCompletedSaveOnce implements IWorkoutSessionRepository {
  _FailCompletedSaveOnce(this._delegate);

  final IWorkoutSessionRepository _delegate;
  bool _failed = false;

  @override
  Future<Result<void, Failure>> save(WorkoutSession session) {
    if (!_failed && session.status == SessionStatus.completed) {
      _failed = true;
      return Future.value(
        const Result.error(DatabaseFailure('Simulated final-write failure')),
      );
    }
    return _delegate.save(session);
  }

  @override
  Future<Result<WorkoutSession, Failure>> getById(String id) =>
      _delegate.getById(id);

  @override
  Future<Result<List<WorkoutSession>, Failure>> listUnfinished(String userId) =>
      _delegate.listUnfinished(userId);

  @override
  Future<Result<List<WorkoutSession>, Failure>> listAll() =>
      _delegate.listAll();
}
