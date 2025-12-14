import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/repositories/drift_activity_repository.dart';
import 'package:growth_gauge/data/services/persistence/app_database.dart';
import 'package:growth_gauge/features/activity/model/activity.dart';

void main() {
  test('DriftActivityRepository save and load activity and log', () async {
    final db = AppDatabase.inMemory();
    final repo = DriftActivityRepository(db);

    final activity = Activity(name: 'Squats', type: ActivityType.countBased, unit: 'reps');
    await repo.saveActivity(activity);

    final activities = await repo.loadActivities();
    expect(activities.length, 1);
    expect(activities.first.name, 'Squats');

    final log = ActivityLog(activityId: activity.id, value: 20);
    await repo.saveLog(log);

    final logs = await repo.loadLogs(activity.id);
    expect(logs.length, 1);
    expect(logs.first.value, 20);
  });

  test('DriftActivityRepository dailyAggregates returns summed days', () async {
    final db = await AppDatabase.inMemory();
    final repo = DriftActivityRepository(db);

    final a = Activity(name: 'Squats', type: ActivityType.countBased, unit: 'reps');
    await repo.saveActivity(a);

    final now = DateTime.now();
    final d1 = DateTime(now.year, now.month, now.day);
    final d2 = d1.subtract(const Duration(days: 1));

    await repo.saveLog(ActivityLog(activityId: a.id, value: 10, timestamp: d1));
    await repo.saveLog(ActivityLog(activityId: a.id, value: 5, timestamp: d1));
    await repo.saveLog(ActivityLog(activityId: a.id, value: 7, timestamp: d2));

    final aggs = await repo.dailyAggregates(a.id, d2.subtract(const Duration(days: 1)), d1.add(const Duration(days: 1)));

    // Find totals by day
    final map = {for (var e in aggs) e['day'] as String: (e['total'] as num).toDouble()};
    expect(map[d1.toIso8601String().split('T').first], 15.0);
    expect(map[d2.toIso8601String().split('T').first], 7.0);

    await db.close();
  });
}

