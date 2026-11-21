import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/time/app_clock.dart';
import '../domain/equipment_inventory.dart';
import '../domain/training_goal.dart';
import '../domain/training_profile.dart';
import '../domain/user_account.dart';
import '../domain/user_enums.dart';
import '../domain/user_profile.dart';
import '../domain/workout_preferences.dart';
import 'user_use_cases.dart';

class const OnboardingState({
  final int currentStep = 0,
  final bool isLoading = false,
  final bool isCompleted = false,
  final String? errorMessage,
  required final UserAccount account,
  required final UserProfile profile,
  required final TrainingProfile trainingProfile,
  required final EquipmentInventory equipmentInventory,
  required final WorkoutPreferences preferences,
  final TrainingGoal? goal,
  final Map<MeasurementType, double> optionalMeasurements = const {},
}) {
  factory initial(String userId) {
    final now = AppClock.nowUtc();
    return OnboardingState(
      account: UserAccount(id: userId, createdAt: now, updatedAt: now),
      profile: UserProfile(userId: userId, createdAt: now, updatedAt: now),
      trainingProfile: TrainingProfile(userId: userId, updatedAt: now),
      equipmentInventory: EquipmentInventory(
        userId: userId,
        ownedEquipment: [],
        updatedAt: now,
      ),
      preferences: WorkoutPreferences(userId: userId),
    );
  }

  OnboardingState copyWith({
    int? currentStep,
    bool? isLoading,
    bool? isCompleted,
    String? errorMessage,
    UserAccount? account,
    UserProfile? profile,
    TrainingProfile? trainingProfile,
    EquipmentInventory? equipmentInventory,
    WorkoutPreferences? preferences,
    TrainingGoal? goal,
    bool clearGoal = false,
    Map<MeasurementType, double>? optionalMeasurements,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
      account: account ?? this.account,
      profile: profile ?? this.profile,
      trainingProfile: trainingProfile ?? this.trainingProfile,
      equipmentInventory: equipmentInventory ?? this.equipmentInventory,
      preferences: preferences ?? this.preferences,
      goal: clearGoal ? null : goal ?? this.goal,
      optionalMeasurements: optionalMeasurements ?? this.optionalMeasurements,
    );
  }
}

class OnboardingCubit(
  final UserUseCases _useCases, {
  required final String userId,
}) extends Cubit<OnboardingState> {
  this : super(OnboardingState.initial(userId));

  void setStep(int step) => emit(state.copyWith(currentStep: step));

  void updateProfile(UserProfile Function(UserProfile) updater) {
    emit(state.copyWith(profile: updater(state.profile)));
  }

  void updateTrainingProfile(
    TrainingProfile Function(TrainingProfile) updater,
  ) {
    emit(state.copyWith(trainingProfile: updater(state.trainingProfile)));
  }

  void updateEquipmentInventory(
    EquipmentInventory Function(EquipmentInventory) updater,
  ) {
    emit(state.copyWith(equipmentInventory: updater(state.equipmentInventory)));
  }

  void updatePreferences(
    WorkoutPreferences Function(WorkoutPreferences) updater,
  ) {
    emit(state.copyWith(preferences: updater(state.preferences)));
  }

  void updateGoal(TrainingGoal? newGoal) {
    emit(state.copyWith(goal: newGoal, clearGoal: newGoal == null));
  }

  void updateOptionalMeasurement(MeasurementType type, double? value) {
    final measurements = Map<MeasurementType, double>.from(
      state.optionalMeasurements,
    );
    if (value == null || value <= 0) {
      measurements.remove(type);
    } else {
      measurements[type] = value;
    }
    emit(state.copyWith(optionalMeasurements: measurements));
  }

  Future<void> completeOnboarding() async {
    final displayName = state.profile.displayName.trim();
    if (displayName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Enter a display name to continue.'));
      return;
    }
    final age = state.profile.ageYears;
    if (age == null || age < 13 || age > 120) {
      emit(state.copyWith(errorMessage: 'Enter an age between 13 and 120.'));
      return;
    }
    final weightKg = state.trainingProfile.baselineWeightKg;
    if (weightKg == null || weightKg <= 0) {
      emit(state.copyWith(errorMessage: 'Enter a valid body weight.'));
      return;
    }
    final heightCm = state.trainingProfile.baselineHeightCm;
    if (heightCm != null && (heightCm < 50 || heightCm > 275)) {
      emit(state.copyWith(errorMessage: 'Enter a valid height.'));
      return;
    }
    final restingHeartRate = state.trainingProfile.restingHeartRateBpm;
    if (restingHeartRate != null &&
        (restingHeartRate < 30 || restingHeartRate > 220)) {
      emit(state.copyWith(errorMessage: 'Enter a valid resting heart rate.'));
      return;
    }
    final goal = state.goal;
    if (goal != null &&
        (goal.name.trim().isEmpty || goal.startValue == goal.targetValue)) {
      emit(state.copyWith(errorMessage: 'Enter a valid training goal.'));
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      await _persist(_useCases.updateAccount(state.account));
      await _persist(_useCases.updateProfile(state.profile));
      await _persist(_useCases.updateTrainingProfile(state.trainingProfile));
      await _persist(
        _useCases.updateEquipmentInventory(
          userId,
          state.equipmentInventory.ownedEquipment,
        ),
      );
      await _persist(_useCases.updatePreferences(state.preferences));
      await _persist(
        _useCases.logMeasurement(
          id: 'onboarding-$userId-${MeasurementType.bodyWeight.name}',
          userId: userId,
          type: MeasurementType.bodyWeight,
          value: weightKg,
          unit: 'kg',
          recordedAt: state.account.createdAt,
          source: 'onboarding',
        ),
      );

      for (final entry in state.optionalMeasurements.entries) {
        final unit = entry.key == MeasurementType.bodyFatPercent ? '%' : 'cm';
        await _persist(
          _useCases.logMeasurement(
            id: 'onboarding-$userId-${entry.key.name}',
            userId: userId,
            type: entry.key,
            value: entry.value,
            unit: unit,
            recordedAt: state.account.createdAt,
            source: 'onboarding',
          ),
        );
      }

      if (goal != null) {
        await _persist(
          _useCases.createGoal(
            id: 'onboarding-$userId',
            userId: userId,
            type: goal.type,
            name: goal.name,
            description: goal.description,
            startValue: goal.startValue,
            targetValue: goal.targetValue,
            unit: goal.unit,
            targetDate: goal.targetDate,
          ),
        );
      }

      final saved = await SharedPreferencesHelper.setHasCompletedOnboarding(
        true,
      );
      if (!saved) throw StateError('Could not save onboarding completion.');
      emit(state.copyWith(isLoading: false, isCompleted: true));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> _persist<T>(Future<Result<T, Failure>> operation) async {
    final result = await operation;
    if (result.isError) throw StateError(result.errorOrNull.toString());
  }
}
