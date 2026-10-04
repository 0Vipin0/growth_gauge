import 'dart:async';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/events/domain_event_dispatcher.dart';
import '../../catalog/domain/exercise.dart';
import '../../catalog/infrastructure/exercise_repository.dart';
import '../../session/domain/session_enums.dart';
import '../../session/domain/session_events.dart';
import '../../session/domain/workout_session.dart';
import '../../session/infrastructure/session_repository.dart';
import '../domain/pr_calculator.dart';

/// Listens to [WorkoutSessionCompleted] domain events and projects each
/// completed [WorkoutSession] into the five Drift analytics tables
/// inside a single atomic transaction (Step 4.3).
///
/// **Idempotency guarantee:** every projection starts by deleting all existing
/// rows for the session, so projecting the same session twice is safe.
class AnalyticsProjector {
  final AppDatabase _db;
  final PRCalculator _prCalculator;
  final IWorkoutSessionRepository _sessionRepo;
  final IExerciseRepository _exerciseRepo;
  StreamSubscription<WorkoutSessionCompleted>? _subscription;

  AnalyticsProjector({
    required this._db,
    required this._prCalculator,
    required this._sessionRepo,
    required this._exerciseRepo,
  });

  /// Subscribes to the global [DomainEventDispatcher].
  void start(DomainEventDispatcher dispatcher) {
    _subscription = dispatcher.subscribe<WorkoutSessionCompleted>(
      (event) => _onSessionCompleted(event.aggregateId),
    );
  }

  Future<void> _onSessionCompleted(String sessionId) async {
    await projectById(sessionId);
  }

  /// Cancels the event subscription. Call on app teardown.
  Future<void> stop() async => _subscription?.cancel();

  /// Projects a single session by ID. May be called directly by the rebuilder.
  Future<void> projectById(String sessionId) async {
    final result = await _sessionRepo.getById(sessionId);
    await result.when(
      success: (session) => project(session),
      error: (_) => Future<void>.value(), // Session not found — skip silently.
    );
  }

  /// Projects [session] into all analytics tables transactionally.
  Future<void> project(WorkoutSession session) async {
    if (session.status != SessionStatus.completed) return;
    final completedAt = session.completedAt ?? session.createdAt;

    // Resolve exercise catalog to extract muscle group data.
    final exerciseCache = <String, Exercise>{};

    await _db.transaction(() async {
      // ── 1. Idempotent cleanup ──────────────────────────────────────────────
      await (_db.delete(
        _db.dailyWorkoutSummaries,
      )..where((t) => t.sessionId.equals(session.id))).go();
      await (_db.delete(
        _db.exerciseSetMetrics,
      )..where((t) => t.sessionId.equals(session.id))).go();
      await (_db.delete(
        _db.personalRecords,
      )..where((t) => t.sessionId.equals(session.id))).go();
      await (_db.delete(
        _db.restIntervalMetrics,
      )..where((t) => t.sessionId.equals(session.id))).go();

      // ── 2. Collect completed sets ──────────────────────────────────────────
      double totalVolume = 0;
      int totalSets = 0;
      int totalReps = 0;
      final List<double> rpeValues = [];
      final Map<String, double> exerciseSessionVolume = {};

      for (final block in session.blocks) {
        for (final item in block.items) {
          for (final set in item.sets) {
            if (set.status != ExecutionSetStatus.completed) continue;
            final w = set.actualWeight;
            final r = set.actualReps;
            final vol = PRCalculator.setVolumeLoad(w, r);
            final est1Rm = PRCalculator.estimated1Rm(w, r);

            totalSets++;
            if (r != null) totalReps += r;
            if (vol != null) totalVolume += vol;
            if (set.rpe != null) rpeValues.add(set.rpe!);

            // Exercise set metric row.
            await _db
                .into(_db.exerciseSetMetrics)
                .insert(
                  ExerciseSetMetricsCompanion(
                    id: Value(set.id),
                    sessionId: Value(session.id),
                    exerciseId: Value(item.exerciseId),
                    userId: Value(session.userId),
                    timestamp: Value(set.completedAt ?? completedAt),
                    weightKg: Value(w),
                    reps: Value(r),
                    volumeLoad: Value(vol),
                    estimated1Rm: Value(est1Rm),
                    rpe: Value(set.rpe),
                    rir: Value(set.rir),
                    setType: Value(set.setType.name),
                  ),
                );

            // PR evaluation for this set.
            final prRows = await _prCalculator.evaluatePRs(
              _db,
              userId: session.userId,
              exerciseId: item.exerciseId,
              sessionId: session.id,
              setId: set.id,
              achievedAt: completedAt,
              weightKg: w,
              reps: r,
              volumeLoad: vol,
              est1Rm: est1Rm,
            );
            for (final pr in prRows) {
              await _db.into(_db.personalRecords).insert(pr);
            }

            // Accumulate per-exercise session volume.
            exerciseSessionVolume[item.exerciseId] =
                (exerciseSessionVolume[item.exerciseId] ?? 0) + (vol ?? 0);

            // Populate exercise cache for muscle volume breakdown.
            if (!exerciseCache.containsKey(item.exerciseId)) {
              final ex = await _exerciseRepo.findById(item.exerciseId);
              ex.when(
                success: (e) => exerciseCache[item.exerciseId] = e,
                error: (_) {},
              );
            }
          }

          // Rest interval metrics.
          for (final rest in session.restIntervals.where(
            (r) => item.sets.any((s) => s.id == r.executionSetId),
          )) {
            if (rest.endedAt == null) continue;
            await _db
                .into(_db.restIntervalMetrics)
                .insert(
                  RestIntervalMetricsCompanion(
                    id: Value(rest.id),
                    sessionId: Value(session.id),
                    executionSetId: Value(rest.executionSetId),
                    exerciseId: Value(item.exerciseId),
                    userId: Value(session.userId),
                    startedAt: Value(rest.startedAt),
                    endedAt: Value(rest.endedAt),
                    plannedDurationSeconds: Value(rest.plannedDurationSeconds),
                    actualDurationSeconds: Value(rest.actualDurationSeconds),
                    wasSkipped: Value(rest.skipped),
                  ),
                );
          }
        }
      }

      // ── 3. Per-exercise session-volume PRs ────────────────────────────────
      for (final entry in exerciseSessionVolume.entries) {
        final prRows = await _prCalculator.evaluateSessionVolumePR(
          _db,
          userId: session.userId,
          exerciseId: entry.key,
          sessionId: session.id,
          achievedAt: completedAt,
          sessionVolumeKg: entry.value,
        );
        for (final pr in prRows) {
          await _db.into(_db.personalRecords).insert(pr);
        }
      }

      // ── 4. Daily workout summary ───────────────────────────────────────────
      final now = DateTime.now().toUtc();
      final wallClock = session.elapsedWallClockSecondsAt(now);
      final active = session.elapsedActiveSecondsAt(now);
      final avgRpe = rpeValues.isEmpty
          ? null
          : rpeValues.reduce((a, b) => a + b) / rpeValues.length;

      await _db
          .into(_db.dailyWorkoutSummaries)
          .insert(
            DailyWorkoutSummariesCompanion(
              id: Value('${session.id}_summary'),
              date: Value(_midnightUtc(completedAt)),
              sessionId: Value(session.id),
              userId: Value(session.userId),
              templateName: Value(session.templateName),
              durationSeconds: Value(wallClock),
              activeSeconds: Value(active),
              volumeLoadKg: Value(totalVolume),
              totalCompletedSets: Value(totalSets),
              totalCompletedReps: Value(totalReps),
              averageRpe: Value(avgRpe),
            ),
          );

      // ── 5. Muscle volume breakdown (upsert per ISO week) ──────────────────
      final isoDate = _isoYearWeek(completedAt);
      final weekStart = _mondayOfWeek(isoDate.$1, isoDate.$2);

      for (final entry in exerciseSessionVolume.entries) {
        final exercise = exerciseCache[entry.key];
        if (exercise == null) continue;

        final allMuscles = [
          ...exercise.classification.primaryMuscles,
          ...exercise.classification.secondaryMuscles,
        ];
        // Use unique muscles only to avoid double-counting.
        final muscles = allMuscles.toSet();

        for (final muscle in muscles) {
          final rowId =
              '${session.userId}_${muscle.name}_${isoDate.$1}_${isoDate.$2}';
          final existing = await (_db.select(
            _db.muscleVolumeBreakdowns,
          )..where((t) => t.id.equals(rowId))).getSingleOrNull();

          if (existing == null) {
            await _db
                .into(_db.muscleVolumeBreakdowns)
                .insert(
                  MuscleVolumeBreakdownsCompanion(
                    id: Value(rowId),
                    userId: Value(session.userId),
                    muscleGroup: Value(muscle.name),
                    isoYear: Value(isoDate.$1),
                    isoWeek: Value(isoDate.$2),
                    weekStartDate: Value(weekStart),
                    totalVolumeKg: Value(entry.value),
                    totalSets: Value(totalSets),
                  ),
                );
          } else {
            await (_db.update(
              _db.muscleVolumeBreakdowns,
            )..where((t) => t.id.equals(rowId))).write(
              MuscleVolumeBreakdownsCompanion(
                totalVolumeKg: Value(existing.totalVolumeKg + entry.value),
                totalSets: Value(existing.totalSets + totalSets),
              ),
            );
          }
        }
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Date helpers
  // ---------------------------------------------------------------------------

  DateTime _midnightUtc(DateTime dt) => DateTime.utc(dt.year, dt.month, dt.day);

  /// Returns (isoYear, isoWeek) per ISO 8601.
  (int, int) _isoYearWeek(DateTime dt) {
    final d = dt.toUtc();
    final dayOfYear = dt.difference(DateTime.utc(dt.year)).inDays + 1;
    final weekday = d.weekday; // Mon=1, Sun=7
    final weekNumber = ((dayOfYear - weekday + 10) / 7).floor();
    if (weekNumber < 1) {
      final lastYearLastDay = DateTime.utc(d.year - 1, 12, 31);
      return _isoYearWeek(lastYearLastDay);
    }
    if (weekNumber > 52) {
      final nextYearFirstDay = DateTime.utc(d.year + 1);
      if (nextYearFirstDay.weekday <= 4) {
        return (d.year + 1, 1);
      }
    }
    return (d.year, weekNumber);
  }

  DateTime _mondayOfWeek(int isoYear, int isoWeek) {
    final jan4 = DateTime.utc(isoYear, 1, 4);
    final mondayOfWeek1 = jan4.subtract(Duration(days: jan4.weekday - 1));
    return mondayOfWeek1.add(Duration(days: (isoWeek - 1) * 7));
  }
}
