import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/catalog/domain/exercise_enums.dart';
import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';
import 'package:growth_gauge/features/user/application/onboarding_cubit.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/domain/training_goal.dart';
import 'package:growth_gauge/features/user/domain/user_enums.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';
import 'package:growth_gauge/features/user/presentation/widgets/onboarding_step_constraints.dart';
import 'package:growth_gauge/features/user/presentation/widgets/onboarding_step_goals.dart';
import 'package:growth_gauge/features/user/presentation/widgets/onboarding_step_metrics.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding flow', () {
    late AppDatabase database;
    late UserRepository repository;
    late UserUseCases useCases;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await SharedPreferencesHelper.init();
      database = AppDatabase.inMemory();
      repository = UserRepository(database);
      useCases = UserUseCases(repository);
    });

    tearDown(() => database.close());

    test(
      'persists captured profile, training constraints, goal and metrics',
      () async {
        final cubit = OnboardingCubit(useCases, userId: 'onboarding-user');
        cubit.updateProfile(
          (profile) => profile.copyWith(
            displayName: 'Jordan',
            ageYears: 34,
            biologicalSex: BiologicalSex.female,
          ),
        );
        cubit.updateTrainingProfile(
          (profile) => profile.copyWith(
            activityLevel: ActivityLevel.veryActive,
            baselineHeightCm: 172.5,
            baselineWeightKg: 68.0,
            restingHeartRateBpm: 58,
            preferredSessionDurationMinutes: 75,
            injuriesAndLimitations: 'Avoid overhead pressing',
          ),
        );
        cubit.updateEquipmentInventory(
          (inventory) => inventory.copyWith(
            ownedEquipment: const [EquipmentType.dumbbell, EquipmentType.bench],
          ),
        );
        cubit.updateOptionalMeasurement(MeasurementType.waist, 74.0);
        cubit.updateGoal(
          TrainingGoal(
            id: 'onboarding-goal',
            userId: 'onboarding-user',
            type: GoalType.strength,
            name: 'Deadlift 120 kg',
            startValue: 80,
            targetValue: 120,
            currentValue: 80,
            startDate: DateTime.utc(2026),
            createdAt: DateTime.utc(2026),
          ),
        );

        await cubit.completeOnboarding();

        expect(cubit.state.isCompleted, isTrue);
        expect(cubit.state.errorMessage, isNull);
        expect(
          (await repository.getAccount('onboarding-user')).isSuccess,
          isTrue,
        );
        final profile = (await repository.getProfile('onboarding-user'))
            .dataOrNull!;
        expect(profile.displayName, 'Jordan');
        expect(profile.ageYears, 34);
        expect(profile.biologicalSex, BiologicalSex.female);
        final training = (await repository.getTrainingProfile(
          'onboarding-user',
        )).dataOrNull!;
        expect(training.baselineHeightCm, 172.5);
        expect(training.baselineWeightKg, 68.0);
        expect(training.restingHeartRateBpm, 58);
        expect(training.activityLevel, ActivityLevel.veryActive);
        expect(training.preferredSessionDurationMinutes, 75);
        expect(training.injuriesAndLimitations, 'Avoid overhead pressing');
        final inventory = (await repository.getEquipmentInventory(
          'onboarding-user',
        )).dataOrNull!;
        expect(inventory.ownedEquipment, [
          EquipmentType.dumbbell,
          EquipmentType.bench,
        ]);
        final measurements = (await repository.listMeasurements(
          'onboarding-user',
        )).dataOrNull!;
        expect(
          measurements.map((measurement) => measurement.type),
          containsAll([MeasurementType.bodyWeight, MeasurementType.waist]),
        );
        expect(
          measurements
              .firstWhere((m) => m.type == MeasurementType.bodyWeight)
              .value,
          68,
        );
        expect(
          (await repository.listGoals('onboarding-user')).dataOrNull,
          hasLength(1),
        );
        expect(SharedPreferencesHelper.getHasCompletedOnboarding(), isTrue);

        await cubit.close();
      },
    );

    test(
      'does not complete when required profile fields are missing',
      () async {
        final cubit = OnboardingCubit(useCases, userId: 'incomplete-user');

        await cubit.completeOnboarding();

        expect(cubit.state.isCompleted, isFalse);
        expect(cubit.state.errorMessage, contains('age between 13 and 120'));
        expect(SharedPreferencesHelper.getHasCompletedOnboarding(), isFalse);
        expect(
          (await repository.getProfile('incomplete-user')).isError,
          isTrue,
        );
        await cubit.close();
      },
    );

    testWidgets('onboarding step widgets update the onboarding state', (
      tester,
    ) async {
      final cubit = OnboardingCubit(useCases, userId: 'widget-onboarding-user');
      Widget host(Widget child) => MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(value: cubit, child: child),
        ),
      );

      await tester.pumpWidget(host(const OnboardingStepMetrics()));
      final metricFields = find.byType(TextField);
      await tester.enterText(metricFields.at(0), 'Taylor');
      await tester.enterText(metricFields.at(1), '32');
      await tester.enterText(metricFields.at(2), '175');
      await tester.enterText(metricFields.at(3), '72');
      expect(cubit.state.profile.displayName, 'Taylor');
      expect(cubit.state.profile.ageYears, 32);
      expect(cubit.state.trainingProfile.baselineHeightCm, 175);
      expect(cubit.state.trainingProfile.baselineWeightKg, 72);

      await tester.pumpWidget(host(const OnboardingStepGoals()));
      final goalFields = find.byType(TextField);
      await tester.enterText(goalFields.at(0), 'Run 5 km');
      await tester.enterText(goalFields.at(2), '5');
      expect(cubit.state.goal?.name, 'Run 5 km');
      expect(cubit.state.goal?.targetValue, 5);

      await tester.pumpWidget(host(const OnboardingStepConstraints()));
      await tester.enterText(
        find.byType(TextField).first,
        'Avoid deep squats for now',
      );
      expect(
        cubit.state.trainingProfile.injuriesAndLimitations,
        'Avoid deep squats for now',
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await cubit.close();
    });
  });
}
