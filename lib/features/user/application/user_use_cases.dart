import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/ids/unique_id.dart';
import '../../../core/time/app_clock.dart';
import '../../catalog/domain/exercise_enums.dart';
import '../domain/equipment_inventory.dart';
import '../domain/training_goal.dart';
import '../domain/training_profile.dart';
import '../domain/user_enums.dart';
import '../domain/user_measurement.dart';
import '../domain/user_profile.dart';
import '../domain/workout_preferences.dart';
import '../infrastructure/user_repository.dart';

/// Application orchestration for user profile, goals, measurements, and equipment.
class UserUseCases(final IUserRepository _repo) {
  // ---------------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------------

  Future<Result<UserProfile, Failure>> getOrCreateProfile(String userId) async {
    final existing = await _repo.getProfile(userId);
    if (existing.isSuccess) return existing;

    final now = AppClock.nowUtc();
    final profile = UserProfile(userId: userId, createdAt: now, updatedAt: now);
    final saveRes = await _repo.saveProfile(profile);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(profile);
  }

  Future<Result<void, Failure>> updateProfile(UserProfile profile) {
    return _repo.saveProfile(profile.copyWith(updatedAt: AppClock.nowUtc()));
  }

  // ---------------------------------------------------------------------------
  // Training Profile
  // ---------------------------------------------------------------------------

  Future<Result<TrainingProfile, Failure>> getOrCreateTrainingProfile(
    String userId,
  ) async {
    final existing = await _repo.getTrainingProfile(userId);
    if (existing.isSuccess) return existing;

    final profile = TrainingProfile(
      userId: userId,
      updatedAt: AppClock.nowUtc(),
    );
    final saveRes = await _repo.saveTrainingProfile(profile);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(profile);
  }

  Future<Result<void, Failure>> updateTrainingProfile(TrainingProfile profile) {
    return _repo.saveTrainingProfile(
      profile.copyWith(updatedAt: AppClock.nowUtc()),
    );
  }

  // ---------------------------------------------------------------------------
  // Workout Preferences
  // ---------------------------------------------------------------------------

  Future<Result<WorkoutPreferences, Failure>> getOrCreatePreferences(
    String userId,
  ) async {
    final existing = await _repo.getPreferences(userId);
    if (existing.isSuccess) return existing;

    const prefs = WorkoutPreferences(userId: '');
    final toSave = prefs.copyWith(userId: userId);
    final saveRes = await _repo.savePreferences(toSave);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(toSave);
  }

  Future<Result<void, Failure>> updatePreferences(
    WorkoutPreferences preferences,
  ) {
    return _repo.savePreferences(preferences);
  }

  // ---------------------------------------------------------------------------
  // Goals
  // ---------------------------------------------------------------------------

  Future<Result<TrainingGoal, Failure>> createGoal({
    required String userId,
    required GoalType type,
    required String name,
    String description = '',
    required double startValue,
    required double targetValue,
    String unit = 'kg',
    DateTime? startDate,
    DateTime? targetDate,
  }) async {
    if (name.trim().isEmpty) {
      return const Result.error(
        ValidationFailure('Goal name cannot be empty.'),
      );
    }
    if (startValue == targetValue) {
      return const Result.error(
        ValidationFailure('Target value must be different from start value.'),
      );
    }

    final now = AppClock.nowUtc();
    final goal = TrainingGoal(
      id: UniqueId.generate().value,
      userId: userId,
      type: type,
      name: name.trim(),
      description: description.trim(),
      startValue: startValue,
      targetValue: targetValue,
      currentValue: startValue,
      unit: unit,
      startDate: startDate ?? now,
      targetDate: targetDate,
      createdAt: now,
    );

    final saveRes = await _repo.saveGoal(goal);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(goal);
  }

  Future<Result<TrainingGoal, Failure>> updateGoalProgress(
    String goalId,
    double newValue,
  ) async {
    final goalRes = await _repo.getGoal(goalId);
    if (goalRes.isError) return goalRes;

    final goal = goalRes.dataOrNull!;
    final isAscending = goal.targetValue > goal.startValue;
    final achieved = isAscending
        ? newValue >= goal.targetValue
        : newValue <= goal.targetValue;

    final updated = goal.copyWith(
      currentValue: newValue,
      status: achieved ? GoalStatus.achieved : goal.status,
      completedAt: achieved ? AppClock.nowUtc() : goal.completedAt,
    );

    final saveRes = await _repo.saveGoal(updated);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(updated);
  }

  Future<Result<void, Failure>> completeGoal(String goalId) async {
    final goalRes = await _repo.getGoal(goalId);
    if (goalRes.isError) return Result.error(goalRes.errorOrNull!);

    final updated = goalRes.dataOrNull!.copyWith(
      status: GoalStatus.achieved,
      completedAt: AppClock.nowUtc(),
    );
    return await _repo.saveGoal(updated);
  }

  Future<Result<void, Failure>> abandonGoal(String goalId) async {
    final goalRes = await _repo.getGoal(goalId);
    if (goalRes.isError) return Result.error(goalRes.errorOrNull!);

    final updated = goalRes.dataOrNull!.copyWith(status: GoalStatus.abandoned);
    return await _repo.saveGoal(updated);
  }

  Future<Result<void, Failure>> deleteGoal(String goalId) =>
      _repo.deleteGoal(goalId);

  Future<Result<List<TrainingGoal>, Failure>> listGoals(String userId) =>
      _repo.listGoals(userId);

  Stream<List<TrainingGoal>> watchGoals(String userId) =>
      _repo.watchGoals(userId);

  // ---------------------------------------------------------------------------
  // Measurements
  // ---------------------------------------------------------------------------

  Future<Result<UserMeasurement, Failure>> logMeasurement({
    required String userId,
    required MeasurementType type,
    required double value,
    required String unit,
    DateTime? recordedAt,
    String source = 'manual',
    String? notes,
  }) async {
    if (value <= 0) {
      return const Result.error(
        ValidationFailure('Measurement value must be greater than zero.'),
      );
    }

    final measurement = UserMeasurement(
      id: UniqueId.generate().value,
      userId: userId,
      type: type,
      value: value,
      unit: unit,
      recordedAt: recordedAt ?? AppClock.nowUtc(),
      source: source,
      notes: notes,
    );

    final saveRes = await _repo.saveMeasurement(measurement);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(measurement);
  }

  Future<Result<List<UserMeasurement>, Failure>> listMeasurements(
    String userId, {
    MeasurementType? type,
  }) => _repo.listMeasurements(userId, type: type);

  Stream<List<UserMeasurement>> watchMeasurements(
    String userId, {
    MeasurementType? type,
  }) => _repo.watchMeasurements(userId, type: type);

  Future<Result<UserMeasurement?, Failure>> getLatestMeasurement(
    String userId,
    MeasurementType type,
  ) async {
    final listRes = await _repo.listMeasurements(userId, type: type);
    if (listRes.isError) return Result.error(listRes.errorOrNull!);
    final list = listRes.dataOrNull!;
    return Result.success(list.isEmpty ? null : list.first);
  }

  // ---------------------------------------------------------------------------
  // Equipment Inventory
  // ---------------------------------------------------------------------------

  Future<Result<EquipmentInventory, Failure>> getOrCreateEquipmentInventory(
    String userId,
  ) async {
    final existing = await _repo.getEquipmentInventory(userId);
    if (existing.isSuccess) return existing;

    final inventory = EquipmentInventory(
      userId: userId,
      ownedEquipment: const [
        EquipmentType.bodyweight,
        EquipmentType.barbell,
        EquipmentType.dumbbell,
        EquipmentType.bench,
      ],
      updatedAt: AppClock.nowUtc(),
    );
    final saveRes = await _repo.saveEquipmentInventory(inventory);
    if (saveRes.isError) return Result.error(saveRes.errorOrNull!);
    return Result.success(inventory);
  }

  Future<Result<void, Failure>> updateEquipmentInventory(
    String userId,
    List<EquipmentType> equipment,
  ) {
    final inventory = EquipmentInventory(
      userId: userId,
      ownedEquipment: equipment,
      updatedAt: AppClock.nowUtc(),
    );
    return _repo.saveEquipmentInventory(inventory);
  }

  Stream<EquipmentInventory?> watchEquipmentInventory(String userId) =>
      _repo.watchEquipmentInventory(userId);
}
