import 'dart:convert';

import 'package:drift/drift.dart';

import '../../features/activity/model/activity.dart';
import '../services/persistence/app_database.dart';
import 'activity_repository.dart';

class DriftActivityRepository implements ActivityRepository {
  final AppDatabase db;

  DriftActivityRepository(this.db);

  @override
  Future<List<Activity>> loadActivities() async {
    final rows = await (db.select(db.activities)).get();
    return rows
        .map((r) => Activity.fromJson({
              'id': r.id,
              'name': r.name,
              'description': r.description,
              'type': r.type,
              'unit': r.unit,
              'is_favorite': r.isFavorite,
              'goal_id': r.goalId,
            }))
        .toList();
  }

  @override
  Future<void> saveActivity(Activity activity) async {
    await db.into(db.activities).insertOnConflictUpdate(ActivitiesCompanion(
      id: Value(activity.id),
      name: Value(activity.name),
      description: Value(activity.description),
      type: Value(activity.type.index),
      unit: Value(activity.unit),
      isFavorite: Value(activity.isFavorite),
      goalId: Value(activity.goalId),
    ));
  }

  @override
  Future<void> saveLog(ActivityLog log) async {
    await db.into(db.activityLogs).insertOnConflictUpdate(ActivityLogsCompanion(
      id: Value(log.id),
      activityId: Value(log.activityId),
      timestamp: Value(log.timestamp),
      value: Value(log.value),
      notes: Value(log.notes),
      rpe: Value(log.rpe),
    ));
  }

  @override
  Future<List<ActivityLog>> loadLogs(String activityId) async {
    final rows = await (db.select(db.activityLogs)..where((t) => t.activityId.equals(activityId))).get();
    return rows
        .map((r) => ActivityLog.fromJson({
              'id': r.id,
              'activity_id': r.activityId,
              'timestamp': r.timestamp.toIso8601String(),
              'value': r.value,
              'notes': r.notes,
              'rpe': r.rpe,
            }))
        .toList();
  }

  @override
  Future<List<ActivityLog>> loadLogsInRange(String activityId, DateTime from, DateTime to) async {
    final rows = await (db.select(db.activityLogs)
          ..where((t) => t.activityId.equals(activityId))
          ..where((t) => t.timestamp.isBetweenValues(from, to)))
        .get();
    return rows
        .map((r) => ActivityLog.fromJson({
              'id': r.id,
              'activity_id': r.activityId,
              'timestamp': r.timestamp.toIso8601String(),
              'value': r.value,
              'notes': r.notes,
              'rpe': r.rpe,
            }))
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> dailyAggregates(String activityId, DateTime from, DateTime to) async {
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

