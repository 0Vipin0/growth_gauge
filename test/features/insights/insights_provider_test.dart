import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/data/repositories/activity_repository.dart';
import 'package:growth_gauge/ui/insights/provider/insights_provider.dart';

class FakeActivityRepo implements ActivityRepository {
  final List<Map<String, dynamic>> _aggs;
  FakeActivityRepo(this._aggs);

  @override
  Future<List<Map<String, dynamic>>> dailyAggregates(
          String activityId, DateTime from, DateTime to) async =>
      _aggs;

  // Not used in this test
  @override
  Future<List<ActivityLog>> loadLogs(String activityId) =>
      throw UnimplementedError();
  @override
  Future<List<ActivityLog>> loadLogsInRange(
          String activityId, DateTime from, DateTime to) =>
      throw UnimplementedError();
  @override
  Future<List<Activity>> loadActivities() => throw UnimplementedError();
  @override
  Future<void> saveActivity(Activity activity) => throw UnimplementedError();
  @override
  Future<void> saveLog(ActivityLog log) => throw UnimplementedError();
}

void main() {
  test('InsightsProvider fetches and parses daily aggregates', () async {
    final fake = FakeActivityRepo([
      {'day': DateTime.now().toIso8601String().split('T').first, 'total': 5},
      {
        'day': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String()
            .split('T')
            .first,
        'total': 2
      },
    ]);

    final provider = InsightsProvider(repository: fake);
    await provider.fetchDailyAggregates(
        'a', DateTime.now().subtract(const Duration(days: 7)), DateTime.now());

    expect(provider.daily.length, 2);
    expect(provider.daily.first, isA<DailyAggregate>());
  });
}
