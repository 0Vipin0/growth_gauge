import 'package:growth_gauge/data/models/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> loadActivities();
  Future<Activity?> loadActivityById(String id);
  Future<void> saveActivity(Activity activity);
  Future<void> saveLog(ActivityLog log);
  Future<List<ActivityLog>> loadLogs(String activityId);
  Future<List<ActivityLog>> loadLogsInRange(String activityId, DateTime from, DateTime to);
  /// Returns a list of maps with keys 'day' (ISO date string) and 'total' (numeric sum for that day)
  Future<List<Map<String, dynamic>>> dailyAggregates(String activityId, DateTime from, DateTime to);
}
