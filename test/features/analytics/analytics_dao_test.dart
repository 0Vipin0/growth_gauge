import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/analytics/application/analytics_cubit.dart';
import 'package:growth_gauge/features/analytics/application/analytics_queries.dart';
import 'package:growth_gauge/features/analytics/domain/analytics_enums.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';
import 'package:growth_gauge/features/analytics/infrastructure/analytics_dao.dart';
import 'package:growth_gauge/features/analytics/projection/analytics_projector.dart';
import 'package:growth_gauge/features/analytics/projection/projection_rebuilder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';

void main() {
  group('AnalyticsDao and AnalyticsCubit Tests', () {
    late AppDatabase db;
    late AnalyticsDao dao;
    late AnalyticsQueries queries;
    late AnalyticsCubit cubit;
    late ProjectionRebuilder rebuilder;

    final now = DateTime.utc(2026, 10, 4, 12);

    setUp(() async {
      db = AppDatabase.inMemory();
      dao = AnalyticsDao(db);
      final sessionRepo = WorkoutSessionRepository(db);
      final exerciseRepo = ExerciseRepository(db);
      final projector = AnalyticsProjector(
        db: db,
        prCalculator: const PRCalculator(),
        sessionRepo: sessionRepo,
        exerciseRepo: exerciseRepo,
      );
      rebuilder = ProjectionRebuilder(
        db: db,
        sessionRepo: sessionRepo,
        projector: projector,
      );
      queries = AnalyticsQueries(dao: dao, rebuilder: rebuilder);
      cubit = AnalyticsCubit(queries: queries, userId: 'user-dao-test');

      // Seed sample data directly into Drift tables
      await db
          .into(db.dailyWorkoutSummaries)
          .insert(
            DailyWorkoutSummariesCompanion(
              id: const Value('summary-1'),
              date: Value(now.subtract(const Duration(days: 2))),
              sessionId: const Value('session-1'),
              userId: const Value('user-dao-test'),
              templateName: const Value('Upper Body'),
              durationSeconds: const Value(3600),
              activeSeconds: const Value(3200),
              volumeLoadKg: const Value(5000.0),
              totalCompletedSets: const Value(15),
              totalCompletedReps: const Value(120),
              averageRpe: const Value(8.0),
            ),
          );

      await db
          .into(db.dailyWorkoutSummaries)
          .insert(
            DailyWorkoutSummariesCompanion(
              id: const Value('summary-2'),
              date: Value(now),
              sessionId: const Value('session-2'),
              userId: const Value('user-dao-test'),
              templateName: const Value('Lower Body'),
              durationSeconds: const Value(4000),
              activeSeconds: const Value(3600),
              volumeLoadKg: const Value(6000.0),
              totalCompletedSets: const Value(18),
              totalCompletedReps: const Value(140),
              averageRpe: const Value(8.5),
            ),
          );

      await db
          .into(db.exerciseSetMetrics)
          .insert(
            ExerciseSetMetricsCompanion(
              id: const Value('set-metric-1'),
              sessionId: const Value('session-1'),
              exerciseId: const Value('exercise-bench-001'),
              userId: const Value('user-dao-test'),
              timestamp: Value(now.subtract(const Duration(days: 2))),
              weightKg: const Value(80.0),
              reps: const Value(5),
              volumeLoad: const Value(400.0),
              estimated1Rm: const Value(93.33),
              setType: const Value('working'),
            ),
          );

      await db
          .into(db.exerciseSetMetrics)
          .insert(
            ExerciseSetMetricsCompanion(
              id: const Value('set-metric-2'),
              sessionId: const Value('session-2'),
              exerciseId: const Value('exercise-bench-001'),
              userId: const Value('user-dao-test'),
              timestamp: Value(now),
              weightKg: const Value(85.0),
              reps: const Value(5),
              volumeLoad: const Value(425.0),
              estimated1Rm: const Value(99.17),
              setType: const Value('working'),
            ),
          );

      await db
          .into(db.personalRecords)
          .insert(
            PersonalRecordsCompanion(
              id: const Value('pr-1'),
              exerciseId: const Value('exercise-bench-001'),
              userId: const Value('user-dao-test'),
              prType: Value(PrType.maxWeight.name),
              value: const Value(85.0),
              sessionId: const Value('session-2'),
              setId: const Value('set-metric-2'),
              achievedAt: Value(now),
            ),
          );

      await db
          .into(db.muscleVolumeBreakdowns)
          .insert(
            MuscleVolumeBreakdownsCompanion(
              id: const Value('user-dao-test_chest_2026_40'),
              userId: const Value('user-dao-test'),
              muscleGroup: const Value('chest'),
              isoYear: const Value(2026),
              isoWeek: const Value(40),
              weekStartDate: Value(now),
              totalVolumeKg: const Value(1200.0),
              totalSets: const Value(6),
            ),
          );
    });

    tearDown(() async {
      await cubit.close();
      await db.close();
    });

    test(
      'watchWorkoutHistory returns summaries ordered descending by date',
      () async {
        final summaries = await dao.watchWorkoutHistory('user-dao-test').first;
        expect(summaries.length, 2);
        expect(summaries.first.sessionId, 'session-2'); // Newest first
        expect(summaries.last.sessionId, 'session-1');
      },
    );

    test(
      'getWorkoutHistoryInRange returns only summaries within range',
      () async {
        final inRange = await dao.getWorkoutHistoryInRange(
          'user-dao-test',
          now.subtract(const Duration(days: 1)),
          now.add(const Duration(days: 1)),
        );
        expect(inRange.length, 1);
        expect(inRange.first.sessionId, 'session-2');
      },
    );

    test(
      'watchExerciseProgression returns sets ordered ascending by timestamp',
      () async {
        final progression = await dao
            .watchExerciseProgression('user-dao-test', 'exercise-bench-001')
            .first;
        expect(progression.length, 2);
        expect(progression.first.weightKg, 80.0); // Oldest first
        expect(progression.last.weightKg, 85.0);
      },
    );

    test('getRecentSets limits and orders descending by timestamp', () async {
      final recent = await dao.getRecentSets(
        'user-dao-test',
        'exercise-bench-001',
        limit: 1,
      );
      expect(recent.length, 1);
      expect(recent.first.weightKg, 85.0); // Most recent
    });

    test(
      'watchPersonalRecords and watchAllPersonalRecords return PR achievements',
      () async {
        final exPrs = await dao
            .watchPersonalRecords('user-dao-test', 'exercise-bench-001')
            .first;
        expect(exPrs.length, 1);
        expect(exPrs.first.value, 85.0);
        expect(exPrs.first.prType, PrType.maxWeight);

        final allPrs = await dao.watchAllPersonalRecords('user-dao-test').first;
        expect(allPrs.length, 1);
        expect(allPrs.first.id, 'pr-1');
      },
    );

    test(
      'watchWeeklyMuscleVolume returns volume stats within weeks window',
      () async {
        final volumes = await dao
            .watchWeeklyMuscleVolume('user-dao-test', weeks: 4)
            .first;
        expect(volumes.length, 1);
        expect(volumes.first.muscleGroup, 'chest');
        expect(volumes.first.totalVolumeKg, 1200.0);
      },
    );

    test(
      'AnalyticsCubit initializes streams and handles exercise selection',
      () async {
        // Allow streams to emit initial state
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(cubit.state.history.length, 2);
        expect(cubit.state.weeklyVolume.length, 1);
        expect(cubit.state.personalRecords.length, 1);

        cubit.selectExercise('exercise-bench-001');
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(cubit.state.selectedExerciseId, 'exercise-bench-001');
        expect(cubit.state.exerciseProgression.length, 2);
      },
    );
  });
}
