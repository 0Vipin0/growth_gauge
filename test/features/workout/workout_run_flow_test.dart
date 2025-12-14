import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:growth_gauge/features/workout/provider/workout_template_provider.dart';
import 'package:growth_gauge/features/workout/provider/workout_run_provider.dart';
import 'package:growth_gauge/features/workout/model/workout_template.dart';
import 'package:growth_gauge/features/workout/widgets/workout_templates_page.dart';

void main() {
  testWidgets('Start a workout and navigate steps', (WidgetTester tester) async {
    final templates = WorkoutTemplateProvider();
    final run = WorkoutRunProvider();

    final t = WorkoutTemplate(name: 'Test', steps: [
      {'name': 'Warmup', 'duration': 2},
      {'name': 'Main', 'reps': 10},
    ]);

    await templates.addTemplate(t);

    await tester.pumpWidget(MaterialApp(home: MultiProvider(providers: [ChangeNotifierProvider<WorkoutTemplateProvider>.value(value: templates), ChangeNotifierProvider<WorkoutRunProvider>.value(value: run)], child: const WorkoutTemplatesPage())));

    await tester.pumpAndSettle();

    expect(find.text('HIIT'), findsNothing);
    expect(find.text('Test'), findsOneWidget);

    await tester.tap(find.text('Test'));
    await tester.pumpAndSettle();

    // Detail page should show steps
    expect(find.text('Steps'), findsOneWidget);

    // Start workout
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();

    // Run page should show step 1 and a timer counting down
    expect(find.textContaining('Step 1/2'), findsOneWidget);

    // Wait for timer to tick a bit
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('s'), findsWidgets);

    // Move to next
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();

    expect(find.textContaining('Step 2/2'), findsOneWidget);
    expect(find.textContaining('reps'), findsOneWidget);
  });
}
