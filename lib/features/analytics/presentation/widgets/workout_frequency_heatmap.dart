import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/daily_workout_summary.dart';

/// GitHub-style calendar consistency grid for workout frequency.
class const WorkoutFrequencyHeatmap({
  super.key,
  required final List<DailyWorkoutSummary> summaries,
  final int daysToShow = 70,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(now.year, now.month, now.day);
    final startDate = today.subtract(Duration(days: daysToShow - 1));

    // Map date (YYYY-MM-DD) to session count
    final dateCounts = <String, int>{};
    for (final s in summaries) {
      final key =
          '${s.date.year}-${s.date.month.toString().padLeft(2, '0')}-${s.date.day.toString().padLeft(2, '0')}';
      dateCounts[key] = (dateCounts[key] ?? 0) + 1;
    }

    final weeks = (daysToShow / 7).ceil();

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(weeks, (weekIndex) {
                return Column(
                  children: List.generate(7, (dayIndex) {
                    final dayOffset = (weekIndex * 7) + dayIndex;
                    if (dayOffset >= daysToShow) {
                      return const SizedBox(width: 14, height: 14);
                    }
                    final date = startDate.add(Duration(days: dayOffset));
                    final key =
                        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                    final count = dateCounts[key] ?? 0;

                    Color boxColor;
                    if (count == 0) {
                      boxColor = colorScheme.surfaceContainerHighest;
                    } else if (count == 1) {
                      boxColor = colorScheme.primary.withValues(alpha: 0.5);
                    } else {
                      boxColor = colorScheme.primary;
                    }

                    return Semantics(
                      label:
                          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}: $count workouts',
                      child: Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
