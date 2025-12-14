import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/activity.dart';
import 'package:growth_gauge/ui/activity/provider/activity_provider.dart';
import 'package:growth_gauge/ui/activity/widgets/activity_detail_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('ActivityDetailPage shows chart and quick-log FAB adds a log', (WidgetTester tester) async {
    final provider = ActivityProvider();
    final a = Activity(name: 'Cycling', type: ActivityType.timeBased, unit: 'minutes');
    provider.addActivity(a);

    // Add an initial log so chart has data
    provider.logActivityEntry(ActivityLog(activityId: a.id, value: 20.0, timestamp: DateTime.now().subtract(const Duration(days: 2))));
    provider.logActivityEntry(ActivityLog(activityId: a.id, value: 30.0, timestamp: DateTime.now().subtract(const Duration(days: 1))));

    final initialCount = provider.logs.where((l) => l.activityId == a.id).length;

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<ActivityProvider>.value(
        value: provider,
        child: Builder(builder: (context) {
          // push the detail page with the activity id as route arg
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(MaterialPageRoute(settings: RouteSettings(arguments: a.id), builder: (_) => const ActivityDetailPage()));
          });
          return const SizedBox.shrink();
        }),
      ),
    ));

    await tester.pumpAndSettle();

    // The chart should be present when logs exist
    expect(find.byType(LineChart), findsOneWidget);

    // Tap the FAB to quick-log a new entry
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final afterCount = provider.logs.where((l) => l.activityId == a.id).length;
    expect(afterCount, initialCount + 1);
  });
}
