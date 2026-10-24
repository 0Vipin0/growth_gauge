import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/analytics/domain/analytics_enums.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';

void main() {
  group('PRCalculator formula unit tests', () {
    test('epley calculates correct 1RM for various rep ranges', () {
      // 100kg x 1 rep => 100kg
      expect(PRCalculator.epley(100.0, 1), 100.0);

      // 100kg x 5 reps => 100 * (1 + 5/30) = 116.666...
      expect(PRCalculator.epley(100.0, 5), closeTo(116.67, 0.01));

      // 80kg x 10 reps => 80 * (1 + 10/30) = 106.666...
      expect(PRCalculator.epley(80.0, 10), closeTo(106.67, 0.01));

      // Invalid inputs return null
      expect(PRCalculator.epley(0.0, 5), isNull);
      expect(PRCalculator.epley(-50.0, 5), isNull);
      expect(PRCalculator.epley(100.0, 0), isNull);
      expect(PRCalculator.epley(100.0, -1), isNull);
    });

    test('brzycki calculates correct 1RM for valid rep ranges', () {
      // 100kg x 1 rep => 100kg
      expect(PRCalculator.brzycki(100.0, 1), 100.0);

      // 100kg x 5 reps => 100 * 36 / (37 - 5) = 112.5
      expect(PRCalculator.brzycki(100.0, 5), 112.5);

      // Reps >= 37 returns null (formula breaks down)
      expect(PRCalculator.brzycki(100.0, 37), isNull);
      expect(PRCalculator.brzycki(100.0, 40), isNull);

      // Invalid inputs return null
      expect(PRCalculator.brzycki(0.0, 5), isNull);
      expect(PRCalculator.brzycki(100.0, 0), isNull);
    });

    test('estimated1Rm returns highest estimate without failing on nulls', () {
      // 100kg x 5 reps: Epley ~116.67, Brzycki = 112.5 => max is ~116.67
      expect(PRCalculator.estimated1Rm(100.0, 5), closeTo(116.67, 0.01));

      expect(PRCalculator.estimated1Rm(null, 5), isNull);
      expect(PRCalculator.estimated1Rm(100.0, null), isNull);
      expect(PRCalculator.estimated1Rm(0.0, 5), isNull);
      expect(PRCalculator.estimated1Rm(100.0, 0), isNull);
    });

    test('setVolumeLoad calculates weight x reps', () {
      expect(PRCalculator.setVolumeLoad(100.0, 5), 500.0);
      expect(PRCalculator.setVolumeLoad(82.5, 8), 660.0);
      expect(PRCalculator.setVolumeLoad(null, 5), isNull);
      expect(PRCalculator.setVolumeLoad(100.0, null), isNull);
      expect(PRCalculator.setVolumeLoad(-10.0, 5), isNull);
      expect(PRCalculator.setVolumeLoad(100.0, 0), isNull);
    });
  });

  group('PRCalculator evaluatePRs database integration', () {
    late AppDatabase db;
    const calculator = PRCalculator();
    final now = DateTime.utc(2026, 10, 4, 12);

    setUp(() {
      db = AppDatabase.inMemory();
    });

    tearDown(() async {
      await db.close();
    });

    test('first set records new PRs for all applicable types', () async {
      final prs = await calculator.evaluatePRs(
        db,
        userId: 'user-1',
        exerciseId: 'exercise-squat-001',
        sessionId: 'session-1',
        setId: 'set-1',
        achievedAt: now,
        weightKg: 100.0,
        reps: 5,
        volumeLoad: 500.0,
        est1Rm: 116.67,
      );

      expect(
        prs.length,
        4,
      ); // maxWeight, estimated1Rm, maxVolumeSet, maxRepsAtWeight
      final types = prs.map((p) => p.prType.value).toSet();
      expect(types, contains(PrType.maxWeight.name));
      expect(types, contains(PrType.estimated1Rm.name));
      expect(types, contains(PrType.maxVolumeSet.name));
      expect(types, contains(PrType.maxRepsAtWeight.name));

      // None have replacesRecordId on first set
      for (final p in prs) {
        expect(p.replacesRecordId.value, isNull);
      }
    });

    test(
      'subsequent higher set breaks PR and chains replacesRecordId',
      () async {
        // 1. First set: 100kg x 5
        final prs1 = await calculator.evaluatePRs(
          db,
          userId: 'user-1',
          exerciseId: 'exercise-squat-001',
          sessionId: 'session-1',
          setId: 'set-1',
          achievedAt: now,
          weightKg: 100.0,
          reps: 5,
          volumeLoad: 500.0,
          est1Rm: 116.67,
        );
        for (final p in prs1) {
          await db.into(db.personalRecords).insert(p);
        }

        // 2. Second set: 105kg x 5 (breaks maxWeight, 1RM, volume)
        final prs2 = await calculator.evaluatePRs(
          db,
          userId: 'user-1',
          exerciseId: 'exercise-squat-001',
          sessionId: 'session-1',
          setId: 'set-2',
          achievedAt: now.add(const Duration(minutes: 5)),
          weightKg: 105.0,
          reps: 5,
          volumeLoad: 525.0,
          est1Rm: 122.5,
        );

        final weightPr = prs2.firstWhere(
          (p) => p.prType.value == PrType.maxWeight.name,
        );
        expect(weightPr.value.value, 105.0);
        expect(weightPr.replacesRecordId.value, isNotNull);

        final est1RmPr = prs2.firstWhere(
          (p) => p.prType.value == PrType.estimated1Rm.name,
        );
        expect(est1RmPr.value.value, 122.5);
        expect(est1RmPr.replacesRecordId.value, isNotNull);
      },
    );

    test('lower or equal set does not record new PRs', () async {
      // First set: 100kg x 5
      final prs1 = await calculator.evaluatePRs(
        db,
        userId: 'user-1',
        exerciseId: 'exercise-squat-001',
        sessionId: 'session-1',
        setId: 'set-1',
        achievedAt: now,
        weightKg: 100.0,
        reps: 5,
        volumeLoad: 500.0,
        est1Rm: 116.67,
      );
      for (final p in prs1) {
        await db.into(db.personalRecords).insert(p);
      }

      // Second set: 90kg x 5 (lower)
      final prs2 = await calculator.evaluatePRs(
        db,
        userId: 'user-1',
        exerciseId: 'exercise-squat-001',
        sessionId: 'session-1',
        setId: 'set-2',
        achievedAt: now.add(const Duration(minutes: 3)),
        weightKg: 90.0,
        reps: 5,
        volumeLoad: 450.0,
        est1Rm: 105.0,
      );

      expect(prs2, isEmpty);
    });

    test(
      'evaluateSessionVolumePR records session volume PR correctly',
      () async {
        final prs = await calculator.evaluateSessionVolumePR(
          db,
          userId: 'user-1',
          exerciseId: 'exercise-squat-001',
          sessionId: 'session-1',
          achievedAt: now,
          sessionVolumeKg: 2500.0,
        );

        expect(prs.length, 1);
        expect(prs.first.prType.value, PrType.maxVolumeSession.name);
        expect(prs.first.value.value, 2500.0);
        expect(prs.first.setId.value, isNull);
      },
    );
  });
}
