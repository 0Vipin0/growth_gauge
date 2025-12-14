import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/workout/provider/workout_template_provider.dart';
import 'package:growth_gauge/features/workout/widgets/workout_templates_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('WorkoutTemplatesPage shows create dialog and adds template', (WidgetTester tester) async {
    final provider = WorkoutTemplateProvider();

    await tester.pumpWidget(MaterialApp(home: ChangeNotifierProvider<WorkoutTemplateProvider>.value(value: provider, child: const WorkoutTemplatesPage())));

    expect(find.text('No workout templates yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('New Template'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'HIIT');
    await tester.enterText(find.byType(TextField).last, 'Interval sprints');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('HIIT'), findsOneWidget);
  });
}
