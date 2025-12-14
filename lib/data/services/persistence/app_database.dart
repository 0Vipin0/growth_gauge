import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../models/activity.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();

  DateTimeColumn get creationDate => dateTime()();

  DateTimeColumn get lastAssessmentDate => dateTime().nullable()();

  IntColumn get fitnessScore => integer().nullable()();

  TextColumn get dataJson => text().nullable()();

  TextColumn get assessmentJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Helper converter for List<String> to String (JSON or comma-separated)
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}

@DataClassName('GoalEntity')
class Goals extends Table {
  TextColumn get id => text().withLength(max: 36)();

  TextColumn get name => text().withLength(min: 1, max: 128)();

  TextColumn get type => text().withLength(max: 50)();

  RealColumn get targetValue => real().nullable()();

  RealColumn get currentValue => real().nullable()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ActivityEntity')
class Activities extends Table {
  TextColumn get id => text().withLength(max: 36)();

  TextColumn get name => text().withLength(min: 1, max: 128)();

  TextColumn get description => text().nullable()();

  TextColumn get unit => text().withLength(min: 1, max: 32)();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get goalId =>
      text().nullable().references(Goals, #id)(); // Foreign Key to Goals
  TextColumn get tags => text().nullable().map(const StringListConverter())();

  // --- Discriminator Field (for Single-Table Inheritance) ---
  // Stores 'countBased' or 'timeBased' to map back to the correct Freezed factory
  TextColumn get activityType =>
      text().withDefault(const Constant('countBased'))();

  // --- Type-Specific Fields (Nullable) ---
  // Count-based value
  IntColumn get count => integer().nullable()();

  // Time-based value (stored as total seconds)
  IntColumn get durationSeconds => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ActivityLogEntity')
class ActivityLogs extends Table {
  TextColumn get id => text().withLength(max: 36)();

  // Foreign Key to Activities
  TextColumn get activityId => text().references(Activities, #id)();

  DateTimeColumn get timestamp => dateTime()();

  // 'value' stores the logged amount (count or seconds/minutes)
  RealColumn get value => real()();

  TextColumn get notes => text().nullable()();

  IntColumn get rpe => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutTemplates extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  TextColumn get stepsJson => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

Activity activityFromEntity(ActivityEntity entity) {
  switch (entity.activityType) {
    case 'countBased':
      // Ensure the required field is present for this type
      if (entity.count == null) {
        throw Exception('CountBased activity is missing required count field.');
      }
      return Activity.countBased(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        unit: entity.unit,
        isFavorite: entity.isFavorite,
        goalId: entity.goalId,
        tags: entity.tags,
        count: entity.count!,
      );

    case 'timeBased':
      // Ensure the required field is present for this type
      if (entity.durationSeconds == null) {
        throw Exception(
            'TimeBased activity is missing required durationSeconds field.');
      }
      return Activity.timeBased(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        unit: entity.unit,
        isFavorite: entity.isFavorite,
        goalId: entity.goalId,
        tags: entity.tags,
        // Convert the stored seconds back into a Dart Duration object
        duration: Duration(seconds: entity.durationSeconds!),
      );

    default:
      throw Exception('Unknown activity type: ${entity.activityType}');
  }
}

ActivityLog activityLogFromEntity(ActivityLogEntity entity) {
  return ActivityLog(
    id: entity.id,
    activityId: entity.activityId,
    timestamp: entity.timestamp,
    value: entity.value,
  );
}

Goal goalFromEntity(GoalEntity entity) {
  return Goal(
    id: entity.id,
    name: entity.name,
    type: entity.type,
    startDate: entity.startDate,
    targetValue: entity.targetValue,
    currentValue: entity.currentValue,
    endDate: entity.endDate,
  );
}

/// Converts a Freezed Activity model to a Drift Companion object for insertion/update.
ActivitiesCompanion activityToCompanion(Activity activity) {
  return ActivitiesCompanion(
    id: Value(activity.id),
    name: Value(activity.name),
    description: Value(activity.description),
    unit: Value(activity.unit),
    isFavorite: Value(activity.isFavorite),
    goalId: Value(activity.goalId),
    tags: Value(activity.tags),

    // Type-specific fields
    activityType: Value(activity.when(
      countBased: (String id, String name, String? description, String unit,
              bool isFavorite, String? goalId, List<String>? tags, int count) =>
          'countBased',
      timeBased: (String id,
              String name,
              String? description,
              String unit,
              bool isFavorite,
              String? goalId,
              List<String>? tags,
              Duration duration) =>
          'timeBased',
    )),
    count: Value(activity.when(
      countBased: (
        String id,
        String name,
        String? description,
        String unit,
        bool isFavorite,
        String? goalId,
        List<String>? tags,
        int count,
      ) =>
          count,
      timeBased: (
        String id,
        String name,
        String? description,
        String unit,
        bool isFavorite,
        String? goalId,
        List<String>? tags,
        Duration duration,
      ) =>
          null,
    )),
    durationSeconds: Value(activity.when(
      countBased: (
        String id,
        String name,
        String? description,
        String unit,
        bool isFavorite,
        String? goalId,
        List<String>? tags,
        int count,
      ) =>
          null,
      timeBased: (
        String id,
        String name,
        String? description,
        String unit,
        bool isFavorite,
        String? goalId,
        List<String>? tags,
        Duration duration,
      ) =>
          duration.inSeconds,
    )),
  );
}

ActivityLogsCompanion activityLogToCompanion(ActivityLog activityLog) {
  return ActivityLogsCompanion(
    id: Value(activityLog.id),
    activityId: Value(activityLog.activityId),
    timestamp: Value(activityLog.timestamp),
    value: Value(activityLog.value),
    notes: Value(activityLog.notes),
    rpe: Value(activityLog.rpe),
  );
}

GoalsCompanion goalToCompanion(Goal activityLog) {
  return GoalsCompanion(
    id: Value(activityLog.id),
    name: Value(activityLog.name),
    type: Value(activityLog.type),
    targetValue: Value(activityLog.targetValue),
    currentValue: Value(activityLog.currentValue),
    startDate: Value(activityLog.startDate),
    endDate: Value(activityLog.endDate),
  );
}

@DriftAccessor(tables: [Goals])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(AppDatabase db) : super(db);

  Future<void> insertGoal(Goal activity) {
    // Convert the Freezed model to a Drift Companion object
    final companion = goalToCompanion(activity);
    return into(goals).insert(companion);
  }

  Future<List<Goal>> getAllGoals() async {
    final allEntities = await select(goals).get();
    return allEntities.map(goalFromEntity).toList();
  }

  Future<Goal?> getGoalById(String id) async {
    final entity =
        await (select(goals)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (entity == null) return null;
    return goalFromEntity(entity);
  }

  Future<void> updateGoal(Goal activity) {
    final companion = goalToCompanion(activity);
    return update(goals).replace(companion);
  }

  Future<void> deleteGoal(String id) {
    return (delete(goals)..where((t) => t.id.equals(id))).go();
  }
}

@DriftAccessor(tables: [Activities, ActivityLogs])
class ActivityDao extends DatabaseAccessor<AppDatabase>
    with _$ActivityDaoMixin {
  ActivityDao(AppDatabase db) : super(db);

  Future<void> insertActivity(Activity activity) {
    // Convert the Freezed model to a Drift Companion object
    final companion = activityToCompanion(activity);
    return into(activities).insert(companion);
  }

  Future<void> insertActivityLog(ActivityLog activityLog) {
    // Convert the Freezed model to a Drift Companion object
    final companion = activityLogToCompanion(activityLog);
    return into(activityLogs).insert(companion);
  }

  Future<List<Activity>> getAllActivities() async {
    final allEntities = await select(activities).get();
    return allEntities.map(activityFromEntity).toList();
  }

  Future<List<ActivityLog>> getAllActivityLogs() async {
    final allEntities = await select(activityLogs).get();
    return allEntities.map(activityLogFromEntity).toList();
  }

  Future<Activity?> getActivityById(String id) async {
    final entity = await (select(activities)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (entity == null) return null;
    return activityFromEntity(entity);
  }

  Future<void> updateActivity(Activity activity) {
    final companion = activityToCompanion(activity);
    return update(activities).replace(companion);
  }

  Future<void> deleteActivity(String id) {
    return (delete(activities)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ActivityLog>> loadLogsInRange(
      String activityId, DateTime from, DateTime to) async {
    final rows = await (db.select(db.activityLogs)
          ..where((t) => t.activityId.equals(activityId))
          ..where((t) => t.timestamp.isBetweenValues(from, to)))
        .get();
    return rows.map((r) => activityLogFromEntity(r)).toList();
  }

  Future<List<Map<String, dynamic>>> dailyAggregates(
      String activityId, DateTime from, DateTime to) async {
    // Use raw SQL to group by date and sum the values per day
    final results = await db.customSelect(
      'SELECT DATE(timestamp) as day, SUM(value) as total FROM activity_logs WHERE activity_id = ? AND timestamp BETWEEN ? AND ? GROUP BY DATE(timestamp) ORDER BY day',
      variables: [
        Variable.withString(activityId),
        Variable.withDateTime(from),
        Variable.withDateTime(to),
      ],
    ).get();

    return results
        .map((row) => {
              'day': row.data['day'] as String,
              'total': (row.data['total'] as num).toDouble(),
            })
        .toList();
  }
}

@DriftDatabase(
    tables: [Users, Activities, ActivityLogs, Goals, WorkoutTemplates])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'growth_gauge.sqlite'));
    return AppDatabase._(NativeDatabase(file));
  }

  // For tests, allow creating an in-memory DB
  factory AppDatabase.inMemory() => AppDatabase._(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
