import '../../data/models/activity.dart';
import '../services/persistence/app_database.dart';
import 'activity_repository.dart';

class DriftActivityRepository implements ActivityRepository {
  final ActivityDao dao;

  DriftActivityRepository(this.dao);

  @override
  Future<List<Activity>> loadActivities() async {
    return dao.getAllActivities();
  }

  @override
  Future<void> saveActivity(Activity activity) async {
    await dao.insertActivity(activity);
  }

  @override
  Future<void> saveLog(ActivityLog log) async {
    await dao.insertActivityLog(log);
  }

  @override
  Future<List<ActivityLog>> loadLogs(String activityId) async {
    return await dao.getAllActivityLogs();
  }

  @override
  Future<List<ActivityLog>> loadLogsInRange(
      String activityId, DateTime from, DateTime to) async {
    return await dao.loadLogsInRange(activityId, from, to);
  }

  @override
  Future<List<Map<String, dynamic>>> dailyAggregates(String activityId, DateTime from, DateTime to) async {
    return await dao.dailyAggregates(activityId, from, to);
  }

  @override
  Future<Activity?> loadActivityById(String id) async {
    return await dao.getActivityById(id);
  }
}
