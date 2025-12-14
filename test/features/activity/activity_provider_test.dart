import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/activity.dart';
import 'package:growth_gauge/ui/activity/provider/activity_provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('ActivityProvider add and group activities', () {
    final provider = ActivityProvider();

    final goal = Goal(name: 'Strength', type: 'Strength', id: const Uuid().v4(), startDate: DateTime.now());
    provider.addGoal(goal);

    final a1 = Activity(id: const Uuid().v4(),name: 'Pushups', type: ActivityType.countBased, unit: 'reps', goalId: goal.id);
    final a2 = Activity(id: const Uuid().v4(),name: 'Plank', type: ActivityType.timeBased, unit: 'seconds');

    provider.addActivity(a1);
    provider.addActivity(a2);

    final map = provider.activitiesByGoal;

    expect(map[goal.id], isNotNull);
    expect(map['ungrouped']!.length, 1);
  });

  test('ActivityProvider logging entries', () {
    final provider = ActivityProvider();
    final a = Activity(id: const Uuid().v4(),name: 'Run', type: ActivityType.timeBased, unit: 'minutes');
    provider.addActivity(a);

    final log = ActivityLog(id: const Uuid().v4(),activityId: a.id, value: 30, timestamp: DateTime.now());
    provider.logActivityEntry(log);

    final logs = provider.getLogsForRange(a.id, DateTime.now().subtract(const Duration(days: 1)), DateTime.now().add(const Duration(days: 1)));
    expect(logs.length, 1);
  });
}
