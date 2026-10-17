import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/features/catalog/domain/exercise_enums.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/domain/equipment_inventory.dart';
import 'package:growth_gauge/features/user/domain/training_goal.dart';
import 'package:growth_gauge/features/user/domain/user_enums.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';

void main() {
  group('UserUseCases', () {
    late AppDatabase db;
    late UserRepository repository;
    late UserUseCases useCases;

    setUp(() {
      db = AppDatabase.inMemory();
      repository = UserRepository(db);
      useCases = UserUseCases(repository);
    });

    tearDown(() async {
      await db.close();
    });

    test('getOrCreateProfile creates default profile if not present', () async {
      final res = await useCases.getOrCreateProfile('user-42');
      expect(res.isSuccess, isTrue);
      final profile = res.dataOrNull!;
      expect(profile.userId, 'user-42');
      expect(profile.displayName, 'Athlete');

      // Subsequent call returns the existing profile
      final secondRes = await useCases.getOrCreateProfile('user-42');
      expect(secondRes.isSuccess, isTrue);
      expect(secondRes.dataOrNull!.userId, 'user-42');
    });

    test('updateProfile modifies profile and sets updatedAt', () async {
      final p = (await useCases.getOrCreateProfile('user-42')).dataOrNull!;
      final updated = p.copyWith(displayName: 'Super Athlete');
      final updateRes = await useCases.updateProfile(updated);
      expect(updateRes.isSuccess, isTrue);

      final fetched = (await useCases.getOrCreateProfile('user-42'))
          .dataOrNull!;
      expect(fetched.displayName, 'Super Athlete');
    });

    test('getOrCreateTrainingProfile and updateTrainingProfile', () async {
      final res = await useCases.getOrCreateTrainingProfile('user-42');
      expect(res.isSuccess, isTrue);
      expect(
        res.dataOrNull!.trainingExperience,
        TrainingExperience.intermediate,
      );

      final updated = res.dataOrNull!.copyWith(
        trainingExperience: TrainingExperience.advanced,
        primaryTrainingStyle: 'Hypertrophy',
      );
      await useCases.updateTrainingProfile(updated);

      final fetched = (await useCases.getOrCreateTrainingProfile('user-42'))
          .dataOrNull!;
      expect(fetched.trainingExperience, TrainingExperience.advanced);
      expect(fetched.primaryTrainingStyle, 'Hypertrophy');
    });

    test('getOrCreatePreferences and updatePreferences', () async {
      final res = await useCases.getOrCreatePreferences('user-42');
      expect(res.isSuccess, isTrue);
      expect(res.dataOrNull!.defaultRestSeconds, 90);

      final updated = res.dataOrNull!.copyWith(defaultRestSeconds: 180);
      await useCases.updatePreferences(updated);

      final fetched = (await useCases.getOrCreatePreferences('user-42'))
          .dataOrNull!;
      expect(fetched.defaultRestSeconds, 180);
    });

    group('Goal orchestration', () {
      test('rejects empty name with ValidationFailure', () async {
        final res = await useCases.createGoal(
          userId: 'user-42',
          type: GoalType.strength,
          name: '   ',
          startValue: 100,
          targetValue: 120,
        );
        expect(res.isError, isTrue);
        expect(res.errorOrNull, isA<ValidationFailure>());
      });

      test('rejects startValue equal to targetValue', () async {
        final res = await useCases.createGoal(
          userId: 'user-42',
          type: GoalType.strength,
          name: 'Bench Press',
          startValue: 100,
          targetValue: 100,
        );
        expect(res.isError, isTrue);
        expect(res.errorOrNull, isA<ValidationFailure>());
      });

      test('creates and tracks goal progress to achievement', () async {
        final createRes = await useCases.createGoal(
          userId: 'user-42',
          type: GoalType.strength,
          name: 'Bench Press 100kg',
          startValue: 80,
          targetValue: 100,
        );
        expect(createRes.isSuccess, isTrue);
        final goal = createRes.dataOrNull!;
        expect(goal.status, GoalStatus.active);
        expect(goal.progressPercent, 0.0);

        // Update progress halfway
        final halfRes = await useCases.updateGoalProgress(goal.id, 90);
        expect(halfRes.isSuccess, isTrue);
        expect(halfRes.dataOrNull!.progressPercent, 0.5);
        expect(halfRes.dataOrNull!.status, GoalStatus.active);

        // Update progress reaching target
        final completeRes = await useCases.updateGoalProgress(goal.id, 100);
        expect(completeRes.isSuccess, isTrue);
        expect(completeRes.dataOrNull!.progressPercent, 1.0);
        expect(completeRes.dataOrNull!.status, GoalStatus.achieved);
        expect(completeRes.dataOrNull!.completedAt, isNotNull);
      });

      test('abandonGoal and deleteGoal', () async {
        final goal = (await useCases.createGoal(
          userId: 'user-42',
          type: GoalType.endurance,
          name: '5k Run',
          startValue: 0,
          targetValue: 5,
        )).dataOrNull!;

        final abandonRes = await useCases.abandonGoal(goal.id);
        expect(abandonRes.isSuccess, isTrue);

        final goals = (await useCases.listGoals('user-42')).dataOrNull!;
        expect(goals.first.status, GoalStatus.abandoned);

        final deleteRes = await useCases.deleteGoal(goal.id);
        expect(deleteRes.isSuccess, isTrue);

        final afterDelete = (await useCases.listGoals('user-42')).dataOrNull!;
        expect(afterDelete, isEmpty);
      });
    });

    group('Measurement orchestration', () {
      test('rejects non-positive measurement value', () async {
        final res = await useCases.logMeasurement(
          userId: 'user-42',
          type: MeasurementType.bodyWeight,
          value: 0,
          unit: 'kg',
        );
        expect(res.isError, isTrue);
        expect(res.errorOrNull, isA<ValidationFailure>());
      });

      test('logs measurement and retrieves latest', () async {
        final m1 = (await useCases.logMeasurement(
          userId: 'user-42',
          type: MeasurementType.bodyWeight,
          value: 75.0,
          unit: 'kg',
          recordedAt: DateTime(2026),
        )).dataOrNull!;
        expect(m1.value, 75.0);

        await useCases.logMeasurement(
          userId: 'user-42',
          type: MeasurementType.bodyWeight,
          value: 74.2,
          unit: 'kg',
          recordedAt: DateTime(2026, 1, 10),
        );

        final latest = (await useCases.getLatestMeasurement(
          'user-42',
          MeasurementType.bodyWeight,
        )).dataOrNull!;
        expect(latest.value, 74.2);
      });
    });

    group('Equipment Inventory orchestration', () {
      test(
        'getOrCreateEquipmentInventory provides baseline defaults',
        () async {
          final inv = (await useCases.getOrCreateEquipmentInventory('user-42'))
              .dataOrNull!;
          expect(inv.ownedEquipment, contains(EquipmentType.bodyweight));
          expect(inv.ownedEquipment, contains(EquipmentType.barbell));
        },
      );

      test('canPerform checks required equipment availability correctly', () {
        final inventory = EquipmentInventory(
          userId: 'user-42',
          ownedEquipment: const [EquipmentType.dumbbell, EquipmentType.bench],
          updatedAt: DateTime(2026),
        );

        // Bodyweight is always available even if not explicitly listed
        expect(inventory.hasEquipment(EquipmentType.bodyweight), isTrue);

        // Dumbbells and bench are owned
        expect(
          inventory.canPerform(const [
            EquipmentType.dumbbell,
            EquipmentType.bench,
          ]),
          isTrue,
        );

        // Cable machine is not owned
        expect(
          inventory.canPerform(const [
            EquipmentType.dumbbell,
            EquipmentType.cable,
          ]),
          isFalse,
        );
      });
    });
  });
}
