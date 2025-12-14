import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/repositories/activity_repository.dart';
import 'package:growth_gauge/features/activity/activity.dart';
import 'package:growth_gauge/features/activity/widgets/activity_detail_page.dart';
import 'package:growth_gauge/features/insights/insights.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Tapping insights button opens InsightsPage',
      (WidgetTester tester) async {
    final provider = ActivityProvider();
    final a =
        Activity(name: 'Yoga', type: ActivityType.timeBased, unit: 'minutes');
    provider.addActivity(a);

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<ActivityProvider>.value(
        value: provider,
        child: Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(MaterialPageRoute(
                settings: RouteSettings(arguments: a.id),
                builder: (_) => const ActivityDetailPage()));
          });
          return const SizedBox.shrink();
        }),
      ),
      routes: {
        '/insights': (_) {
          // provide a basic fake repository to the InsightsProvider
          final fake = _FakeRepo();
          return ChangeNotifierProvider<InsightsProvider>(
              create: (_) => InsightsProvider(repository: fake),
              child: const InsightsPage());
        }
      },
    ));

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.insights), findsOneWidget);

    await tester.tap(find.byIcon(Icons.insights));
    await tester.pumpAndSettle();

    expect(find.byType(InsightsPage), findsOneWidget);
  });
}

class _FakeRepo implements ActivityRepository {
  @override
  Future<List<Map<String, dynamic>>> dailyAggregates(
          String activityId, DateTime from, DateTime to) async =>
      [];

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
