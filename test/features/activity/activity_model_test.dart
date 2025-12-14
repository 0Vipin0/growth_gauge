import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/activity.dart';

void main() {
  test('Activity JSON roundtrip', () {
    final activity = Activity(name: 'Pushups', type: ActivityType.countBased, unit: 'reps');
    final json = activity.toJson();
    final fromJson = Activity.fromJson(json);

    expect(fromJson.name, activity.name);
    expect(fromJson.type, activity.type);
    expect(fromJson.unit, activity.unit);
  });

  test('ActivityLog JSON roundtrip', () {
    final log = ActivityLog(activityId: 'a1', value: 15);
    final json = log.toJson();
    final restored = ActivityLog.fromJson(json);

    expect(restored.activityId, 'a1');
    expect(restored.value, 15);
  });
}
