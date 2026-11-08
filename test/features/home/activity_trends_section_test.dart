import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/analytics/domain/daily_workout_summary.dart';
import 'package:growth_gauge/features/home/presentation/widgets/activity_trends_section.dart';

void main() {
  group('ActivityTrendsSection and ActivityTrendsCard', () {
    testWidgets('renders week view with workout checkmarks and days', (
      tester,
    ) async {
      final now = DateTime.now();
      final summaries = [
        DailyWorkoutSummary(
          id: 's-1',
          date: now,
          sessionId: 'sess-1',
          userId: 'u1',
          templateName: 'Full Body',
          durationSeconds: 3000,
          activeSeconds: 2000,
          volumeLoadKg: 4000,
          totalCompletedSets: 8,
          totalCompletedReps: 80,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActivityTrendsCard(
              selectedTimeRange: ActivityTimeRange.week,
              timeOffset: 0,
              periodLabel: 'This Week',
              workoutHistory: summaries,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );

      expect(find.text('This Week'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders month and quarter views', (tester) async {
      final now = DateTime.now();
      final summaries = [
        DailyWorkoutSummary(
          id: 's-1',
          date: now,
          sessionId: 'sess-1',
          userId: 'u1',
          templateName: 'Full Body',
          durationSeconds: 3000,
          activeSeconds: 2000,
          volumeLoadKg: 4000,
          totalCompletedSets: 8,
          totalCompletedReps: 80,
        ),
      ];

      // Test Month View
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActivityTrendsCard(
              selectedTimeRange: ActivityTimeRange.month,
              timeOffset: 0,
              periodLabel: 'Nov 2026',
              workoutHistory: summaries,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );
      expect(find.text('W1'), findsOneWidget);

      // Test Quarter View
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActivityTrendsCard(
              selectedTimeRange: ActivityTimeRange.quarter,
              timeOffset: 0,
              periodLabel: 'Q4 2026',
              workoutHistory: summaries,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );
      expect(find.text('Oct'), findsOneWidget);
      expect(find.text('Nov'), findsOneWidget);
      expect(find.text('Dec'), findsOneWidget);
    });

    testWidgets('triggers onPrevious and onNext on navigation buttons', (
      tester,
    ) async {
      var prevTapped = false;
      var nextTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActivityTrendsCard(
              selectedTimeRange: ActivityTimeRange.week,
              timeOffset: 0,
              periodLabel: 'This Week',
              workoutHistory: const [],
              onPrevious: () => prevTapped = true,
              onNext: () => nextTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Previous period'));
      await tester.pump();
      expect(prevTapped, isTrue);

      await tester.tap(find.byTooltip('Next period'));
      await tester.pump();
      expect(nextTapped, isTrue);
    });
  });
}
