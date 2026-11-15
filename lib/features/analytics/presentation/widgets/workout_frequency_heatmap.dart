import 'package:flutter/material.dart';

import '../../../chart/chart.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/daily_workout_summary.dart';

/// GitHub-style calendar consistency grid for workout frequency using BaseHeatmapWidget.
class const WorkoutFrequencyHeatmap({
  super.key,

  /// List of daily workout summaries.
  required final List<DailyWorkoutSummary> summaries,

  /// Number of days to display.
  final int daysToShow = 70,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Aggregate summaries into a Map<DateTime, int> for BaseHeatmapWidget
    final heatmapData = <DateTime, int>{};
    for (final s in summaries) {
      final date = DateTime(s.date.year, s.date.month, s.date.day);
      heatmapData[date] = (heatmapData[date] ?? 0) + 1;
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Workout Frequency (Last 10 Weeks)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${summaries.length} total',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BaseHeatmapWidget(heatmapData: heatmapData),
        ],
      ),
    );
  }
}
