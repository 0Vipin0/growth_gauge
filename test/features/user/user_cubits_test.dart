import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/user/application/goal_cubit.dart';
import 'package:growth_gauge/features/user/application/measurement_cubit.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/domain/user_enums.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';

void main() {
  group('User Feature Cubits', () {
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

    group('GoalCubit', () {
      test('loads goals and updates state reactively', () async {
        final cubit = GoalCubit(useCases: useCases, userId: 'user-cubit');

        // Initial state is loading
        expect(cubit.state.isLoading, isTrue);

        // Wait for first stream emission
        await pumpEventQueue();
        expect(cubit.state.isLoading, isFalse);
        expect(cubit.state.goals, isEmpty);

        // Create a goal
        await cubit.createGoal(
          type: GoalType.strength,
          name: 'Deadlift 200kg',
          startValue: 140,
          targetValue: 200,
        );

        await pumpEventQueue();
        expect(cubit.state.goals.length, 1);
        expect(cubit.state.activeGoals.length, 1);
        expect(cubit.state.achievedGoals, isEmpty);

        final goalId = cubit.state.goals.first.id;

        // Update progress to completion
        await cubit.updateProgress(goalId, 200);
        await pumpEventQueue();

        expect(cubit.state.activeGoals, isEmpty);
        expect(cubit.state.achievedGoals.length, 1);
        expect(cubit.state.achievedGoals.first.name, 'Deadlift 200kg');

        // Delete goal
        await cubit.deleteGoal(goalId);
        await pumpEventQueue();

        expect(cubit.state.goals, isEmpty);

        await cubit.close();
      });

      test('emits errorMessage on validation error', () async {
        final cubit = GoalCubit(useCases: useCases, userId: 'user-cubit');
        await pumpEventQueue();

        await cubit.createGoal(
          type: GoalType.strength,
          name: '', // Empty name triggers validation failure
          startValue: 100,
          targetValue: 120,
        );

        expect(cubit.state.errorMessage, isNotNull);
        expect(cubit.state.errorMessage, contains('Goal name cannot be empty'));

        await cubit.close();
      });
    });

    group('MeasurementCubit', () {
      test('logs measurements and filters by type', () async {
        final cubit = MeasurementCubit(
          useCases: useCases,
          userId: 'user-cubit',
        );
        await pumpEventQueue();

        expect(cubit.state.measurements, isEmpty);

        // Log body weight
        await cubit.logMeasurement(
          type: MeasurementType.bodyWeight,
          value: 80.0,
          unit: 'kg',
        );
        await pumpEventQueue();

        // Log waist circumference
        await cubit.logMeasurement(
          type: MeasurementType.waist,
          value: 84.0,
          unit: 'cm',
        );
        await cubit.stream.firstWhere((s) => s.measurements.length == 2);
        expect(cubit.state.measurements.length, 2);
        expect(cubit.state.filteredMeasurements.length, 2);

        // Filter by bodyWeight
        cubit.selectType(MeasurementType.bodyWeight);
        expect(cubit.state.filteredMeasurements.length, 1);
        expect(cubit.state.latestMeasurement?.value, 80.0);

        // Filter by waist
        cubit.selectType(MeasurementType.waist);
        expect(cubit.state.filteredMeasurements.length, 1);
        expect(cubit.state.latestMeasurement?.value, 84.0);

        // Reset filter
        cubit.selectType(null);
        expect(cubit.state.filteredMeasurements.length, 2);

        await cubit.close();
      });

      test('emits errorMessage on invalid measurement value', () async {
        final cubit = MeasurementCubit(
          useCases: useCases,
          userId: 'user-cubit',
        );
        await pumpEventQueue();

        await cubit.logMeasurement(
          type: MeasurementType.bodyWeight,
          value: -5.0, // Invalid negative value
          unit: 'kg',
        );

        expect(cubit.state.errorMessage, isNotNull);
        expect(cubit.state.errorMessage, contains('greater than zero'));

        await cubit.close();
      });
    });
  });
}
