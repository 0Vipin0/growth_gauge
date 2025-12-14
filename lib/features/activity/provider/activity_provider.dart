import 'package:flutter/foundation.dart';

import '../../../data/repositories/activity_repository.dart';
import '../model/activity.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityRepository? repository;
  final List<Activity> _activities = [];
  final List<ActivityLog> _logs = [];
  final List<Goal> _goals = [];

  ActivityProvider({this.repository});

  bool _isFetchingDashboard = false;

  bool get isFetchingDashboard => _isFetchingDashboard;
  List<Activity> get activities => List.unmodifiable(_activities);
  List<ActivityLog> get logs => List.unmodifiable(_logs);
  List<Goal> get goals => List.unmodifiable(_goals);

  Map<String, List<Activity>> get activitiesByGoal {
    final Map<String, List<Activity>> map = {};
    for (final a in _activities) {
      final key = a.goalId ?? 'ungrouped';
      map.putIfAbsent(key, () => []).add(a);
    }
    return map;
  }

  Future<void> loadDashboardActivities() async {
    _isFetchingDashboard = true;
    notifyListeners();

    // Load activities and logs from repository if present
    if (repository != null) {
      final loadedActivities = await repository!.loadActivities();
      _activities.clear();
      _activities.addAll(loadedActivities);
      // logs are loaded on demand via repository
    } else {
      // Placeholder for loading from persistence
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }

    _isFetchingDashboard = false;
    notifyListeners();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void logActivityEntry(ActivityLog log) {
    _logs.add(log);
    notifyListeners();
  }

  List<ActivityLog> getLogsForRange(
      String activityId, DateTime from, DateTime to) {
    return _logs
        .where((l) =>
            l.activityId == activityId &&
            l.timestamp.isAfter(from) &&
            l.timestamp.isBefore(to))
        .toList();
  }
}
