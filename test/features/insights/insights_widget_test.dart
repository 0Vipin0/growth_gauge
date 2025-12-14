import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/data/repositories/activity_repository.dart';
import 'package:growth_gauge/ui/insights/provider/insights_provider.dart';
import 'package:growth_gauge/ui/insights/widgets/activity_heatmap.dart';
import 'package:growth_gauge/ui/insights/widgets/insights_page.dart';
import 'package:growth_gauge/ui/insights/widgets/x_day_chart.dart';
import 'package:provider/provider.dart';

class _FakeRepo extends ActivityRepository {
  final List<Map<String, dynamic>> _aggs;
  _FakeRepo(this._aggs);

  @override
  Future<List<Map<String, dynamic>>> dailyAggregates(String activityId, DateTime from, DateTime to) async => _aggs;

  // unused
  @override
  Future<List<ActivityLog>> loadLogs(String activityId) => throw UnimplementedError();
  @override
  Future<List<ActivityLog>> loadLogsInRange(String activityId, DateTime from, DateTime to) => throw UnimplementedError();
  @override
  Future<List<Activity>> loadActivities() => throw UnimplementedError();
  @override
  Future<void> saveActivity(Activity activity) => throw UnimplementedError();
  @override
  Future<void> saveLog(ActivityLog log) => throw UnimplementedError();
}

void main() {
  testWidgets('InsightsPage shows heatmap and chart', (WidgetTester tester) async {
    final fake = _FakeRepo([
      {'day': DateTime.now().toIso8601String().split('T').first, 'total': 5},
      {'day': DateTime.now().subtract(const Duration(days: 1)).toIso8601String().split('T').first, 'total': 2},
    ]);

    final provider = InsightsProvider(repository: fake);

    await tester.pumpWidget(MaterialApp(home: ChangeNotifierProvider<InsightsProvider>.value(value: provider, child: Builder(builder: (context) {
      // push page with activity id as arg
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(settings: const RouteSettings(arguments: 'a'), builder: (_) => const InsightsPage()));
      });
      return const SizedBox.shrink();
    }))));

    await tester.pumpAndSettle();

    expect(find.byType(ActivityHeatmap), findsOneWidget);
    expect(find.byType(XDayChart), findsOneWidget);
  });
}
