import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';

import '../domain/equipment_inventory.dart';
import '../domain/training_goal.dart';
import '../domain/training_profile.dart';
import '../domain/user_account.dart';
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
}) {
  // Encapsulated existing domain models
  factory initial(String userId) {
    final now = DateTime.now();
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
      goal: goal ?? this.goal,
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
    emit(state.copyWith(goal: newGoal));
  }

  /// Persists all captured domain models via existing use cases
  Future<void> completeOnboarding() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _useCases.updateProfile(
        state.profile.copyWith(updatedAt: DateTime.now()),
      );
      await _useCases.updateTrainingProfile(
        state.trainingProfile.copyWith(updatedAt: DateTime.now()),
      );
      await _useCases.updateEquipmentInventory(
        userId,
        state.equipmentInventory.ownedEquipment,
      );
      await _useCases.updatePreferences(state.preferences);

      if (state.goal != null) {
        await _useCases.createGoal(
          userId: userId,
          type: state.goal!.type,
          name: state.goal!.name,
          description: state.goal!.description,
          startValue: state.goal!.startValue,
          targetValue: state.goal!.targetValue,
          unit: state.goal!.unit,
          targetDate: state.goal!.targetDate,
        );
      }
      SharedPreferencesHelper.setHasCompletedOnboarding(true);
      emit(state.copyWith(isLoading: false, isCompleted: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
