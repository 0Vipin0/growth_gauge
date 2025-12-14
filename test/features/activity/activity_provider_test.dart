import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/activity/activity.dart';

void main() {
  test('ActivityProvider add and group activities', () {
    final provider = ActivityProvider();

    final goal = Goal(name: 'Strength', type: 'Strength');
    provider.addGoal(goal);

    final a1 = Activity(name: 'Pushups', type: ActivityType.countBased, unit: 'reps', goalId: goal.id);
    final a2 = Activity(name: 'Plank', type: ActivityType.timeBased, unit: 'seconds');

    provider.addActivity(a1);
    provider.addActivity(a2);

    final map = provider.activitiesByGoal;

    expect(map[goal.id], isNotNull);
    expect(map['ungrouped']!.length, 1);
  });

  test('ActivityProvider logging entries', () {
    final provider = ActivityProvider();
    final a = Activity(name: 'Run', type: ActivityType.timeBased, unit: 'minutes');
    provider.addActivity(a);

    final log = ActivityLog(activityId: a.id, value: 30);
    provider.logActivityEntry(log);

    final logs = provider.getLogsForRange(a.id, DateTime.now().subtract(const Duration(days: 1)), DateTime.now().add(const Duration(days: 1)));
    expect(logs.length, 1);
  });
}
