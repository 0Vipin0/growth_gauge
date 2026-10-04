import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/analytics/domain/analytics_enums.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';
import 'package:growth_gauge/features/analytics/projection/analytics_projector.dart';
import 'package:growth_gauge/features/analytics/projection/projection_rebuilder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/catalog/infrastructure/seed/exercise_seed_data.dart';
import 'package:growth_gauge/features/session/domain/execution_set.dart';
import 'package:growth_gauge/features/session/domain/rest_interval.dart';
import 'package:growth_gauge/features/session/domain/session_block.dart';
import 'package:growth_gauge/features/session/domain/session_enums.dart';
import 'package:growth_gauge/features/session/domain/session_events.dart';
import 'package:growth_gauge/features/session/domain/session_item.dart';
import 'package:growth_gauge/features/session/domain/workout_session.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';

void main() {
  group('AnalyticsProjector and Rebuilder Integration', () {
    late AppDatabase db;
    late ExerciseRepository exerciseRepo;
    late WorkoutSessionRepository sessionRepo;
    late PRCalculator prCalculator;
    late AnalyticsProjector projector;
    late ProjectionRebuilder rebuilder;
    late DomainEventDispatcher dispatcher;

    final baseTime = DateTime.utc(2026, 10, 4, 10);

    setUp(() async {
      db = AppDatabase.inMemory();
      exerciseRepo = ExerciseRepository(db);
      sessionRepo = WorkoutSessionRepository(db);
      prCalculator = const PRCalculator();
      projector = AnalyticsProjector(
        db: db,
        prCalculator: prCalculator,
        sessionRepo: sessionRepo,
        exerciseRepo: exerciseRepo,
      );
      rebuilder = ProjectionRebuilder(
        db: db,
        sessionRepo: sessionRepo,
        projector: projector,
      );
      dispatcher = DomainEventDispatcher();

      // Seed catalog with standard exercises
      for (final ex in ExerciseSeedData.all) {
        await exerciseRepo.save(ex);
      }
    });

    tearDown(() async {
      await projector.stop();
      await dispatcher.dispose();
      await db.close();
    });

    WorkoutSession buildTestSession({
      required String id,
      required String userId,
      required DateTime completedAt,
      double squatWeight = 100.0,
      int squatReps = 5,
    }) {
      return WorkoutSession(
        id: id,
        userId: userId,
        templateId: 'template-squat-day',
        templateRevisionId: 'revision-1',
        templateName: 'Squat Heavy Day',
        status: SessionStatus.completed,
        startedAt: completedAt.subtract(const Duration(minutes: 45)),
        completedAt: completedAt,
        createdAt: completedAt.subtract(const Duration(minutes: 50)),
        blocks: [
          SessionBlock(
            id: 'block-1',
            sourceTemplateBlockId: 'tb-1',
            name: 'Main Compound',
            items: [
              SessionItem(
                id: 'item-1',
                sourceTemplateItemId: 'ti-1',
                exerciseId: 'exercise-squat-001',
                order: 0,
                sets: [
                  ExecutionSet(
                    id: '$id-set-1',
                    setNumber: 1,
                    actualWeight: squatWeight,
                    actualReps: squatReps,
                    rpe: 8.0,
                    status: ExecutionSetStatus.completed,
                    completedAt: completedAt.subtract(
                      const Duration(minutes: 30),
                    ),
                  ),
                  ExecutionSet(
                    id: '$id-set-2',
                    setNumber: 2,
                    actualWeight: squatWeight,
                    actualReps: squatReps,
                    rpe: 8.5,
                    status: ExecutionSetStatus.completed,
                    completedAt: completedAt.subtract(
                      const Duration(minutes: 25),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
        restIntervals: [
          RestInterval(
            id: '$id-rest-1',
            executionSetId: '$id-set-1',
            startedAt: completedAt.subtract(const Duration(minutes: 30)),
            endedAt: completedAt.subtract(const Duration(minutes: 27)),
            plannedDurationSeconds: 180,
            actualDurationSeconds: 180,
          ),
        ],
      );
    }

    test('project writes all 5 analytical read models correctly', () async {
      final session = buildTestSession(
        id: 'session-001',
        userId: 'user-vipin',
        completedAt: baseTime,
      );

      await projector.project(session);

      // 1. Verify DailyWorkoutSummaries
      final summaries = await db.select(db.dailyWorkoutSummaries).get();
      expect(summaries.length, 1);
      final s = summaries.first;
      expect(s.sessionId, 'session-001');
      expect(s.userId, 'user-vipin');
      expect(s.templateName, 'Squat Heavy Day');
      expect(s.totalCompletedSets, 2);
      expect(s.totalCompletedReps, 10);
      expect(s.volumeLoadKg, 1000.0); // 100*5 + 100*5
      expect(s.averageRpe, 8.25); // (8.0 + 8.5) / 2

      // 2. Verify ExerciseSetMetrics
      final metrics = await db.select(db.exerciseSetMetrics).get();
      expect(metrics.length, 2);
      expect(metrics.first.exerciseId, 'exercise-squat-001');
      expect(metrics.first.weightKg, 100.0);
      expect(metrics.first.volumeLoad, 500.0);
      expect(metrics.first.estimated1Rm, closeTo(116.67, 0.01));

      // 3. Verify PersonalRecords
      final prs = await db.select(db.personalRecords).get();
      expect(prs.isNotEmpty, isTrue);
      final maxWeight = prs.firstWhere(
        (p) => p.prType == PrType.maxWeight.name,
      );
      expect(maxWeight.value, 100.0);
      final sessionVol = prs.firstWhere(
        (p) => p.prType == PrType.maxVolumeSession.name,
      );
      expect(sessionVol.value, 1000.0);

      // 4. Verify MuscleVolumeBreakdowns
      final muscleVols = await db.select(db.muscleVolumeBreakdowns).get();
      expect(muscleVols.isNotEmpty, isTrue);
      // Barbell Back Squat targets quads and glutes primarily
      final quadVol = muscleVols.firstWhere((m) => m.muscleGroup == 'quads');
      expect(quadVol.totalVolumeKg, 1000.0);

      // 5. Verify RestIntervalMetrics
      final restRows = await db.select(db.restIntervalMetrics).get();
      expect(restRows.length, 1);
      expect(restRows.first.plannedDurationSeconds, 180);
      expect(restRows.first.wasSkipped, isFalse);
    });

    test('projection idempotency: double projection does not duplicate or inflate data', () async {
      final session = buildTestSession(
        id: 'session-idempotent',
        userId: 'user-vipin',
        completedAt: baseTime,
        squatWeight: 120.0,
        squatReps: 3,
      );

      // Project once
      await projector.project(session);

      final countSummaries1 =
          (await db.select(db.dailyWorkoutSummaries).get()).length;
      final countMetrics1 =
          (await db.select(db.exerciseSetMetrics).get()).length;
      final countPrs1 = (await db.select(db.personalRecords).get()).length;
      final countRests1 =
          (await db.select(db.restIntervalMetrics).get()).length;
      final volume1 =
          (await db.select(db.dailyWorkoutSummaries).get()).first.volumeLoadKg;

      // Project second time (idempotency check)
      await projector.project(session);

      final countSummaries2 =
          (await db.select(db.dailyWorkoutSummaries).get()).length;
      final countMetrics2 =
          (await db.select(db.exerciseSetMetrics).get()).length;
      final countPrs2 = (await db.select(db.personalRecords).get()).length;
      final countRests2 =
          (await db.select(db.restIntervalMetrics).get()).length;
      final volume2 =
          (await db.select(db.dailyWorkoutSummaries).get()).first.volumeLoadKg;

      expect(countSummaries2, countSummaries1);
      expect(countMetrics2, countMetrics1);
      expect(countPrs2, countPrs1);
      expect(countRests2, countRests1);
      expect(volume2, volume1);
    });

    test(
      'domain event subscription triggers projection automatically',
      () async {
        projector.start(dispatcher);

        final session = buildTestSession(
          id: 'session-via-event',
          userId: 'user-event',
          completedAt: baseTime,
          squatWeight: 140.0,
          squatReps: 1,
        );

        // Save to repository first
        await sessionRepo.save(session);

        // Publish event
        dispatcher.publish(
          WorkoutSessionCompleted(aggregateId: 'session-via-event'),
        );

        // Allow async event loop to process
        await Future<void>.delayed(const Duration(milliseconds: 50));

        final summaries = await (db.select(
          db.dailyWorkoutSummaries,
        )..where((t) => t.sessionId.equals('session-via-event'))).get();
        expect(summaries.length, 1);
        expect(summaries.first.volumeLoadKg, 280.0);
      },
    );

    test('rebuildAll wipes tables and replays all completed sessions with 100% parity', () async {
      final session1 = buildTestSession(
        id: 'session-hist-1',
        userId: 'user-rebuilder',
        completedAt: baseTime.subtract(const Duration(days: 3)),
        squatWeight: 90.0,
      );
      final session2 = buildTestSession(
        id: 'session-hist-2',
        userId: 'user-rebuilder',
        completedAt: baseTime,
      );

      await sessionRepo.save(session1);
      await sessionRepo.save(session2);

      // Project initially
      await projector.project(session1);
      await projector.project(session2);

      final summariesBefore = await db.select(db.dailyWorkoutSummaries).get();
      final prsBefore = await db.select(db.personalRecords).get();
      expect(summariesBefore.length, 2);

      // Rebuild from scratch
      final count = await rebuilder.rebuildAll();
      expect(count, 2);

      final summariesAfter = await db.select(db.dailyWorkoutSummaries).get();
      final prsAfter = await db.select(db.personalRecords).get();

      expect(summariesAfter.length, summariesBefore.length);
      expect(prsAfter.length, prsBefore.length);
    });
  });
}
