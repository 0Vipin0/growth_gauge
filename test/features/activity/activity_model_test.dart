import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/activity.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Activity JSON roundtrip', () {
    final activity = Activity(id: const Uuid().v4(),name: 'Pushups', type: ActivityType.countBased, unit: 'reps');
    final json = activity.toJson();
    final fromJson = Activity.fromJson(json);

    expect(fromJson.name, activity.name);
    expect(fromJson.type, activity.type);
    expect(fromJson.unit, activity.unit);
  });

  test('ActivityLog JSON roundtrip', () {
    final log = ActivityLog(id: const Uuid().v4(),activityId: 'a1', timestamp: DateTime.now());
    final json = log.toJson();
    final restored = ActivityLog.fromJson(json);

    expect(restored.activityId, 'a1');
    expect(restored.value, 15);
  });
}
