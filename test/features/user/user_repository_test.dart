import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/units/unit_types.dart';
import 'package:growth_gauge/features/catalog/domain/exercise_enums.dart';
import 'package:growth_gauge/features/user/domain/equipment_inventory.dart';
import 'package:growth_gauge/features/user/domain/training_goal.dart';
import 'package:growth_gauge/features/user/domain/training_profile.dart';
import 'package:growth_gauge/features/user/domain/user_account.dart';
import 'package:growth_gauge/features/user/domain/user_enums.dart';
import 'package:growth_gauge/features/user/domain/user_measurement.dart';
import 'package:growth_gauge/features/user/domain/user_profile.dart';
import 'package:growth_gauge/features/user/domain/workout_preferences.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';

void main() {
  group('UserRepository', () {
    late AppDatabase db;
    late UserRepository repository;

    setUp(() {
      db = AppDatabase.inMemory();
      repository = UserRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('UserProfile CRUD and watchProfile stream', () async {
      final profile = UserProfile(
        userId: 'user-1',
        displayName: 'Test Athlete',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

      final saveRes = await repository.saveProfile(profile);
      expect(saveRes.isSuccess, isTrue);

      final getRes = await repository.getProfile('user-1');
      expect(getRes.isSuccess, isTrue);
      expect(getRes.dataOrNull!.displayName, 'Test Athlete');
      expect(getRes.dataOrNull!.weightUnit, WeightUnit.kilograms);

      final streamFuture = repository.watchProfile('user-1').first;
      final streamed = await streamFuture;
      expect(streamed?.displayName, 'Test Athlete');
    });

    test('UserAccount persists through its document adapter', () async {
      final account = UserAccount(
        id: 'account-1',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

      expect((await repository.saveAccount(account)).isSuccess, isTrue);
      final loaded = await repository.getAccount(account.id);
      expect(loaded.isSuccess, isTrue);
      expect(loaded.dataOrNull, account);
    });

    test('TrainingProfile and WorkoutPreferences CRUD', () async {
      final training = TrainingProfile(
        userId: 'user-1',
        primaryTrainingStyle: 'Powerlifting',
        preferredSessionDurationMinutes: 75,
        updatedAt: DateTime(2026),
      );
      final tRes = await repository.saveTrainingProfile(training);
      expect(tRes.isSuccess, isTrue);

      final getTRes = await repository.getTrainingProfile('user-1');
      expect(getTRes.isSuccess, isTrue);
      expect(
        getTRes.dataOrNull!.trainingExperience,
        TrainingExperience.intermediate,
      );
      expect(getTRes.dataOrNull!.preferredSessionDurationMinutes, 75);

      const prefs = WorkoutPreferences(
        userId: 'user-1',
        defaultRestSeconds: 120,
        vibrationEnabled: false,
      );
      final pRes = await repository.savePreferences(prefs);
      expect(pRes.isSuccess, isTrue);

      final getPRes = await repository.getPreferences('user-1');
      expect(getPRes.isSuccess, isTrue);
      expect(getPRes.dataOrNull!.defaultRestSeconds, 120);
      expect(getPRes.dataOrNull!.vibrationEnabled, isFalse);
    });

    test('TrainingGoal CRUD, list, watch and delete', () async {
      final goal1 = TrainingGoal(
        id: 'goal-1',
        userId: 'user-1',
        type: GoalType.strength,
        name: 'Squat 140kg',
        startValue: 100,
        targetValue: 140,
        currentValue: 120,
        startDate: DateTime(2026),
        createdAt: DateTime(2026),
      );
      final goal2 = TrainingGoal(
        id: 'goal-2',
        userId: 'user-1',
        type: GoalType.bodyWeight,
        name: 'Cut to 75kg',
        startValue: 82,
        targetValue: 75,
        currentValue: 78,
        startDate: DateTime(2026),
        createdAt: DateTime(2026),
      );

      await repository.saveGoal(goal1);
      await repository.saveGoal(goal2);

      final listRes = await repository.listGoals('user-1');
      expect(listRes.isSuccess, isTrue);
      expect(listRes.dataOrNull!.length, 2);

      final watchGoals = await repository.watchGoals('user-1').first;
      expect(watchGoals.length, 2);

      final delRes = await repository.deleteGoal('goal-1');
      expect(delRes.isSuccess, isTrue);

      final afterDel = await repository.listGoals('user-1');
      expect(afterDel.dataOrNull!.length, 1);
      expect(afterDel.dataOrNull!.first.id, 'goal-2');
    });

    test('UserMeasurement time-series log, list filter, and watch', () async {
      final m1 = UserMeasurement(
        id: 'm-1',
        userId: 'user-1',
        type: MeasurementType.bodyWeight,
        value: 80.5,
        unit: 'kg',
        recordedAt: DateTime(2026),
      );
      final m2 = UserMeasurement(
        id: 'm-2',
        userId: 'user-1',
        type: MeasurementType.bodyWeight,
        value: 79.8,
        unit: 'kg',
        recordedAt: DateTime(2026, 1, 15),
      );
      final m3 = UserMeasurement(
        id: 'm-3',
        userId: 'user-1',
        type: MeasurementType.waist,
        value: 82.0,
        unit: 'cm',
        recordedAt: DateTime(2026, 1, 15),
      );

      await repository.saveMeasurement(m1);
      await repository.saveMeasurement(m2);
      await repository.saveMeasurement(m3);

      final allRes = await repository.listMeasurements('user-1');
      expect(allRes.isSuccess, isTrue);
      expect(allRes.dataOrNull!.length, 3);
      // Ensure sorted by recordedAt descending
      expect(allRes.dataOrNull!.first.recordedAt, DateTime(2026, 1, 15));

      final weightOnly = await repository.listMeasurements(
        'user-1',
        type: MeasurementType.bodyWeight,
      );
      expect(weightOnly.dataOrNull!.length, 2);

      final waistOnly = await repository.listMeasurements(
        'user-1',
        type: MeasurementType.waist,
      );
      expect(waistOnly.dataOrNull!.length, 1);
      expect(waistOnly.dataOrNull!.first.value, 82.0);
    });

    test('EquipmentInventory CRUD and watch', () async {
      final inventory = EquipmentInventory(
        userId: 'user-1',
        ownedEquipment: const [
          EquipmentType.bodyweight,
          EquipmentType.barbell,
          EquipmentType.bench,
        ],
        updatedAt: DateTime(2026),
      );

      await repository.saveEquipmentInventory(inventory);

      final getRes = await repository.getEquipmentInventory('user-1');
      expect(getRes.isSuccess, isTrue);
      expect(getRes.dataOrNull!.ownedEquipment.length, 3);
      expect(
        getRes.dataOrNull!.ownedEquipment,
        contains(EquipmentType.barbell),
      );

      final watched = await repository.watchEquipmentInventory('user-1').first;
      expect(watched?.ownedEquipment.length, 3);
    });
  });
}
