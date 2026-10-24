import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/analytics/domain/analytics_enums.dart';
import 'package:growth_gauge/features/analytics/domain/daily_workout_summary.dart';
import 'package:growth_gauge/features/analytics/domain/exercise_set_metric.dart';
import 'package:growth_gauge/features/analytics/domain/muscle_volume_stat.dart';
import 'package:growth_gauge/features/analytics/domain/personal_record.dart';
import 'package:growth_gauge/features/analytics/presentation/widgets/pr_badge_card.dart';
import 'package:growth_gauge/features/analytics/presentation/widgets/progression_line_chart.dart';
import 'package:growth_gauge/features/analytics/presentation/widgets/volume_bar_chart.dart';
import 'package:growth_gauge/features/analytics/presentation/widgets/workout_frequency_heatmap.dart';

void main() {
  group('Analytics Presentation Widgets Tests', () {
    final now = DateTime.utc(2026, 10, 4, 12);

    testWidgets('PrBadgeCard renders record value and type correctly', (
      tester,
    ) async {
      final pr = PersonalRecord(
        id: 'pr-test-1',
        exerciseId: 'exercise-squat-001',
        userId: 'user-1',
        prType: PrType.maxWeight,
        value: 120.0,
        sessionId: 'session-1',
        achievedAt: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrBadgeCard(record: pr, exerciseName: 'Barbell Back Squat'),
          ),
        ),
      );

      expect(find.text('Barbell Back Squat'), findsOneWidget);
      expect(find.textContaining('Max Weight'), findsOneWidget);
      expect(find.text('120.0 kg'), findsOneWidget);
    });

    testWidgets('VolumeBarChart renders empty message when no stats', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: VolumeBarChart(stats: [])),
        ),
      );

      expect(find.text('No volume data logged yet.'), findsOneWidget);
    });

    testWidgets('VolumeBarChart renders chart when stats provided', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final stats = [
        MuscleVolumeStat(
          muscleGroup: 'quads',
          isoYear: 2026,
          isoWeek: 40,
          weekStartDate: now,
          totalVolumeKg: 2000.0,
          totalSets: 10,
        ),
        MuscleVolumeStat(
          muscleGroup: 'glutes',
          isoYear: 2026,
          isoWeek: 40,
          weekStartDate: now,
          totalVolumeKg: 1500.0,
          totalSets: 8,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: VolumeBarChart(stats: stats)),
          ),
        ),
      );

      expect(find.text('Weekly Volume by Muscle (kg)'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          'Weekly volume by muscle group. quads: 2000 kilograms, glutes: 1500 kilograms.',
        ),
        findsOneWidget,
      );
      semantics.dispose();
    });

    testWidgets(
      'ProgressionLineChart renders empty message when no 1RM metrics',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: ProgressionLineChart(metrics: [])),
          ),
        );

        expect(
          find.text('No 1RM data recorded for this exercise yet.'),
          findsOneWidget,
        );
      },
    );

    testWidgets('ProgressionLineChart renders chart with valid metrics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final metrics = [
        ExerciseSetMetric(
          id: 'set-1',
          sessionId: 's-1',
          exerciseId: 'exercise-squat-001',
          userId: 'u-1',
          timestamp: now.subtract(const Duration(days: 7)),
          weightKg: 100.0,
          reps: 5,
          volumeLoad: 500.0,
          estimated1Rm: 116.67,
          setType: 'working',
        ),
        ExerciseSetMetric(
          id: 'set-2',
          sessionId: 's-2',
          exerciseId: 'exercise-squat-001',
          userId: 'u-1',
          timestamp: now,
          weightKg: 105.0,
          reps: 5,
          volumeLoad: 525.0,
          estimated1Rm: 122.5,
          setType: 'working',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProgressionLineChart(metrics: metrics),
            ),
          ),
        ),
      );

      expect(find.text('Estimated 1RM Progression (kg)'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          'Estimated one repetition maximum progression. 2 recorded sets, from 116.7 kilograms to 122.5 kilograms.',
        ),
        findsOneWidget,
      );
      semantics.dispose();
    });

    testWidgets('WorkoutFrequencyHeatmap renders grid and session count', (
      tester,
    ) async {
      final summaries = [
        DailyWorkoutSummary(
          id: 'sum-1',
          date: now.subtract(const Duration(days: 2)),
          sessionId: 's-1',
          userId: 'u-1',
          templateName: 'Upper Body',
          durationSeconds: 3600,
          activeSeconds: 3200,
          volumeLoadKg: 4000.0,
          totalCompletedSets: 12,
          totalCompletedReps: 100,
        ),
        DailyWorkoutSummary(
          id: 'sum-2',
          date: now,
          sessionId: 's-2',
          userId: 'u-1',
          templateName: 'Lower Body',
          durationSeconds: 3800,
          activeSeconds: 3400,
          volumeLoadKg: 5000.0,
          totalCompletedSets: 15,
          totalCompletedReps: 120,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WorkoutFrequencyHeatmap(summaries: summaries),
            ),
          ),
        ),
      );

      expect(find.text('Workout Frequency (Last 10 Weeks)'), findsOneWidget);
      expect(find.text('2 total'), findsOneWidget);
    });
  });
}
