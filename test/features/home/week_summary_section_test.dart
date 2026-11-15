import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/analytics/domain/calorie_calculator.dart';
import 'package:growth_gauge/features/analytics/domain/daily_workout_summary.dart';
import 'package:growth_gauge/features/home/presentation/widgets/week_summary_section.dart';

void main() {
  Widget buildTestWidget({
    required bool isDesktop,
    required List<DailyWorkoutSummary> summaries,
    VoidCallback? onDetailsTap,
    int targetCalories = 3500,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: WeekSummarySection(
          isDesktop: isDesktop,
          summaries: summaries,
          onDetailsTap: onDetailsTap,
          targetCalories: targetCalories,
        ),
      ),
    );
  }

  group('WeekSummarySection', () {
    testWidgets('renders zero state with empty summaries', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(isDesktop: false, summaries: const []),
      );

      expect(find.text('This Week'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);
      expect(find.text('Calories Burned'), findsOneWidget);
      expect(find.text('0'), findsOneWidget); // 0 kcal
      expect(find.text('0%'), findsOneWidget); // 0%
      expect(find.text('0h 0m'), findsOneWidget); // Active Time
      expect(find.text('0'), findsWidgets); // Workouts
    });

    testWidgets('renders calculated calories and active time for this week', (
      tester,
    ) async {
      final now = DateTime.now();
      // Create session on today's date
      final sessionToday = DailyWorkoutSummary(
        id: 's-today',
        date: now,
        sessionId: 'sess-today',
        userId: 'u1',
        templateName: 'Upper Hypertrophy',
        durationSeconds: 3600,
        activeSeconds: 2700, // 45 min
        volumeLoadKg: 5000,
        totalCompletedSets: 12,
        totalCompletedReps: 120,
      );

      final expectedCalories = CalorieCalculator.estimateBurned(
        activeSeconds: 2700,
        volumeLoadKg: 5000,
      );

      await tester.pumpWidget(
        buildTestWidget(
          isDesktop: false,
          summaries: [sessionToday],
          targetCalories: 2000,
        ),
      );

      final expectedProgressPct =
          '${((expectedCalories / 2000) * 100).round()}%';

      expect(find.text(expectedCalories.toString()), findsOneWidget);
      expect(find.text(expectedProgressPct), findsOneWidget);
      expect(find.text('0h 45m'), findsOneWidget);
      expect(find.text('1'), findsWidgets); // 1 workout
    });

    testWidgets('invokes onDetailsTap when Details button is tapped', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          isDesktop: true,
          summaries: const [],
          onDetailsTap: () => tapped = true,
        ),
      );

      final detailsFinder = find.text('Details');
      expect(detailsFinder, findsOneWidget);
      await tester.tap(detailsFinder);
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders desktop grid layout without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(isDesktop: true, summaries: const []),
      );

      expect(find.text('This Week'), findsOneWidget);
      expect(find.text('Calories Burned'), findsOneWidget);
      expect(find.text('Active Time'), findsOneWidget);
      expect(find.text('Workouts'), findsOneWidget);
    });
  });
}
