import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:growth_gauge/features/activity/widgets/activity_list_page.dart';
import 'package:growth_gauge/features/activity/provider/activity_provider.dart';

void main() {
  testWidgets('ActivityListWidget shows new activity when FAB tapped', (WidgetTester tester) async {
    final provider = ActivityProvider();

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<ActivityProvider>.value(value: provider, child: const ActivityListWidget()),
    ));

    expect(find.text('No activities yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('New Activity'), findsOneWidget);
  });
}
