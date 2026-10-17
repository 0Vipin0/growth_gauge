import '../../../core/database/app_database.dart';
import '../../../core/database/document_store.dart';
import '../../../core/database/drift_document_store.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/equipment_inventory.dart';
import '../domain/training_goal.dart';
import '../domain/training_profile.dart';
import '../domain/user_enums.dart';
import '../domain/user_measurement.dart';
import '../domain/user_profile.dart';
import '../domain/workout_preferences.dart';
import 'user_document_adapters.dart';

abstract interface class IUserRepository() {
  Future<Result<void, Failure>> saveProfile(UserProfile profile);
  Future<Result<UserProfile, Failure>> getProfile(String userId);
  Stream<UserProfile?> watchProfile(String userId);

  Future<Result<void, Failure>> saveTrainingProfile(TrainingProfile profile);
  Future<Result<TrainingProfile, Failure>> getTrainingProfile(String userId);

  Future<Result<void, Failure>> savePreferences(WorkoutPreferences preferences);
  Future<Result<WorkoutPreferences, Failure>> getPreferences(String userId);

  Future<Result<void, Failure>> saveGoal(TrainingGoal goal);
  Future<Result<TrainingGoal, Failure>> getGoal(String goalId);
  Future<Result<List<TrainingGoal>, Failure>> listGoals(String userId);
  Future<Result<void, Failure>> deleteGoal(String goalId);
  Stream<List<TrainingGoal>> watchGoals(String userId);

  Future<Result<void, Failure>> saveMeasurement(UserMeasurement measurement);
  Future<Result<List<UserMeasurement>, Failure>> listMeasurements(
    String userId, {
    MeasurementType? type,
  });
  Stream<List<UserMeasurement>> watchMeasurements(
    String userId, {
    MeasurementType? type,
  });

  Future<Result<void, Failure>> saveEquipmentInventory(
    EquipmentInventory inventory,
  );
  Future<Result<EquipmentInventory, Failure>> getEquipmentInventory(
    String userId,
  );
  Stream<EquipmentInventory?> watchEquipmentInventory(String userId);
}

class UserRepository implements IUserRepository {
  final IDocumentStore<UserProfile> _profileStore;
  final IDocumentStore<TrainingProfile> _trainingProfileStore;
  final IDocumentStore<WorkoutPreferences> _preferencesStore;
  final IDocumentStore<TrainingGoal> _goalStore;
  final IDocumentStore<UserMeasurement> _measurementStore;
  final IDocumentStore<EquipmentInventory> _equipmentStore;

  new(AppDatabase db)
    : _profileStore = DriftDocumentStore<UserProfile>(
        database: db,
        adapter: const UserProfileAdapter(),
      ),
      _trainingProfileStore = DriftDocumentStore<TrainingProfile>(
        database: db,
        adapter: const TrainingProfileAdapter(),
      ),
      _preferencesStore = DriftDocumentStore<WorkoutPreferences>(
        database: db,
        adapter: const WorkoutPreferencesAdapter(),
      ),
      _goalStore = DriftDocumentStore<TrainingGoal>(
        database: db,
        adapter: const TrainingGoalAdapter(),
      ),
      _measurementStore = DriftDocumentStore<UserMeasurement>(
        database: db,
        adapter: const UserMeasurementAdapter(),
      ),
      _equipmentStore = DriftDocumentStore<EquipmentInventory>(
        database: db,
        adapter: const EquipmentInventoryAdapter(),
      );

  new withStores({
    required this._profileStore,
    required this._trainingProfileStore,
    required this._preferencesStore,
    required this._goalStore,
    required this._measurementStore,
    required this._equipmentStore,
  });

  // ---------------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> saveProfile(UserProfile profile) =>
      _profileStore.upsert(profile);

  @override
  Future<Result<UserProfile, Failure>> getProfile(String userId) =>
      _profileStore.getById(userId);

  @override
  Stream<UserProfile?> watchProfile(String userId) =>
      _profileStore.watchAll().map((profiles) {
        final matches = profiles.where((p) => p.userId == userId);
        return matches.isEmpty ? null : matches.first;
      });

  // ---------------------------------------------------------------------------
  // Training Profile
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> saveTrainingProfile(TrainingProfile profile) =>
      _trainingProfileStore.upsert(profile);

  @override
  Future<Result<TrainingProfile, Failure>> getTrainingProfile(String userId) =>
      _trainingProfileStore.getById(userId);

  // ---------------------------------------------------------------------------
  // Workout Preferences
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> savePreferences(
    WorkoutPreferences preferences,
  ) => _preferencesStore.upsert(preferences);

  @override
  Future<Result<WorkoutPreferences, Failure>> getPreferences(String userId) =>
      _preferencesStore.getById(userId);

  // ---------------------------------------------------------------------------
  // Goals
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> saveGoal(TrainingGoal goal) =>
      _goalStore.upsert(goal);

  @override
  Future<Result<TrainingGoal, Failure>> getGoal(String goalId) =>
      _goalStore.getById(goalId);

  @override
  Future<Result<List<TrainingGoal>, Failure>> listGoals(String userId) async {
    final result = await _goalStore.getAll();
    return result.map(
      (goals) => goals.where((g) => g.userId == userId).toList(),
    );
  }

  @override
  Future<Result<void, Failure>> deleteGoal(String goalId) =>
      _goalStore.delete(goalId);

  @override
  Stream<List<TrainingGoal>> watchGoals(String userId) => _goalStore
      .watchAll()
      .map((goals) => goals.where((g) => g.userId == userId).toList());

  // ---------------------------------------------------------------------------
  // Measurements
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> saveMeasurement(UserMeasurement measurement) =>
      _measurementStore.upsert(measurement);

  @override
  Future<Result<List<UserMeasurement>, Failure>> listMeasurements(
    String userId, {
    MeasurementType? type,
  }) async {
    final result = await _measurementStore.getAll();
    return result.map((measurements) {
      final userList = measurements.where((m) => m.userId == userId);
      final filtered = type == null
          ? userList
          : userList.where((m) => m.type == type);
      return filtered.toList()
        ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    });
  }

  @override
  Stream<List<UserMeasurement>> watchMeasurements(
    String userId, {
    MeasurementType? type,
  }) => _measurementStore.watchAll().map((measurements) {
    final userList = measurements.where((m) => m.userId == userId);
    final filtered = type == null
        ? userList
        : userList.where((m) => m.type == type);
    return filtered.toList()
      ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
  });

  // ---------------------------------------------------------------------------
  // Equipment Inventory
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void, Failure>> saveEquipmentInventory(
    EquipmentInventory inventory,
  ) => _equipmentStore.upsert(inventory);

  @override
  Future<Result<EquipmentInventory, Failure>> getEquipmentInventory(
    String userId,
  ) => _equipmentStore.getById(userId);

  @override
  Stream<EquipmentInventory?> watchEquipmentInventory(String userId) =>
      _equipmentStore.watchAll().map((inventories) {
        final matches = inventories.where((i) => i.userId == userId);
        return matches.isEmpty ? null : matches.first;
      });
}
