import '../../../core/database/document_adapter.dart';
import '../domain/equipment_inventory.dart';
import '../domain/training_goal.dart';
import '../domain/training_profile.dart';
import '../domain/user_account.dart';
import '../domain/user_measurement.dart';
import '../domain/user_profile.dart';
import '../domain/workout_preferences.dart';

/// Document adapter for [UserAccount] entities.
class const UserAccountAdapter() implements DocumentAdapter<UserAccount> {
  @override
  String get collection => 'user_accounts';

  @override
  String getId(UserAccount entity) => entity.id;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(UserAccount entity) => entity.toJson();

  @override
  UserAccount fromJson(Map<String, dynamic> json) => UserAccount.fromJson(json);

  @override
  DateTime? getCreatedAt(UserAccount entity) => entity.createdAt;

  @override
  DateTime? getUpdatedAt(UserAccount entity) => entity.updatedAt;
}

/// Document adapter for [UserProfile] entities.
class const UserProfileAdapter() implements DocumentAdapter<UserProfile> {
  @override
  String get collection => 'profiles';

  @override
  String getId(UserProfile entity) => entity.userId;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(UserProfile entity) => entity.toJson();

  @override
  UserProfile fromJson(Map<String, dynamic> json) => UserProfile.fromJson(json);

  @override
  DateTime? getCreatedAt(UserProfile entity) => entity.createdAt;

  @override
  DateTime? getUpdatedAt(UserProfile entity) => entity.updatedAt;
}

/// Document adapter for [TrainingProfile] entities.
class const TrainingProfileAdapter()
    implements DocumentAdapter<TrainingProfile> {
  @override
  String get collection => 'training_profiles';

  @override
  String getId(TrainingProfile entity) => entity.userId;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(TrainingProfile entity) => entity.toJson();

  @override
  TrainingProfile fromJson(Map<String, dynamic> json) =>
      TrainingProfile.fromJson(json);

  @override
  DateTime? getCreatedAt(TrainingProfile entity) => null;

  @override
  DateTime? getUpdatedAt(TrainingProfile entity) => entity.updatedAt;
}

/// Document adapter for [WorkoutPreferences] entities.
class const WorkoutPreferencesAdapter()
    implements DocumentAdapter<WorkoutPreferences> {
  @override
  String get collection => 'preferences';

  @override
  String getId(WorkoutPreferences entity) => entity.userId;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(WorkoutPreferences entity) => entity.toJson();

  @override
  WorkoutPreferences fromJson(Map<String, dynamic> json) =>
      WorkoutPreferences.fromJson(json);

  @override
  DateTime? getCreatedAt(WorkoutPreferences entity) => null;

  @override
  DateTime? getUpdatedAt(WorkoutPreferences entity) => null;
}

/// Document adapter for [TrainingGoal] entities.
class const TrainingGoalAdapter() implements DocumentAdapter<TrainingGoal> {
  @override
  String get collection => 'goals';

  @override
  String getId(TrainingGoal entity) => entity.id;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(TrainingGoal entity) => entity.toJson();

  @override
  TrainingGoal fromJson(Map<String, dynamic> json) =>
      TrainingGoal.fromJson(json);

  @override
  DateTime? getCreatedAt(TrainingGoal entity) => entity.createdAt;

  @override
  DateTime? getUpdatedAt(TrainingGoal entity) => entity.completedAt;
}

/// Document adapter for [UserMeasurement] entities.
class const UserMeasurementAdapter()
    implements DocumentAdapter<UserMeasurement> {
  @override
  String get collection => 'measurements';

  @override
  String getId(UserMeasurement entity) => entity.id;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(UserMeasurement entity) => entity.toJson();

  @override
  UserMeasurement fromJson(Map<String, dynamic> json) =>
      UserMeasurement.fromJson(json);

  @override
  DateTime? getCreatedAt(UserMeasurement entity) => entity.recordedAt;

  @override
  DateTime? getUpdatedAt(UserMeasurement entity) => null;
}

/// Document adapter for [EquipmentInventory] entities.
class const EquipmentInventoryAdapter()
    implements DocumentAdapter<EquipmentInventory> {
  @override
  String get collection => 'equipment_inventories';

  @override
  String getId(EquipmentInventory entity) => entity.userId;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(EquipmentInventory entity) => entity.toJson();

  @override
  EquipmentInventory fromJson(Map<String, dynamic> json) =>
      EquipmentInventory.fromJson(json);

  @override
  DateTime? getCreatedAt(EquipmentInventory entity) => null;

  @override
  DateTime? getUpdatedAt(EquipmentInventory entity) => entity.updatedAt;
}
