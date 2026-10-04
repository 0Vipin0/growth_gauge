import 'package:flutter/material.dart';

import '../../domain/daily_workout_summary.dart';

/// GitHub-style calendar consistency grid for workout frequency.
class WorkoutFrequencyHeatmap extends StatelessWidget {
  final List<DailyWorkoutSummary> summaries;
  final int daysToShow;

  const WorkoutFrequencyHeatmap({
    super.key,
    required this.summaries,
    this.daysToShow = 70, // 10 weeks
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(now.year, now.month, now.day);
    final startDate = today.subtract(Duration(days: daysToShow - 1));

    // Map date (YYYY-MM-DD) to session count or volume
    final dateCounts = <String, int>{};
    for (final s in summaries) {
      final key =
          '${s.date.year}-${s.date.month.toString().padLeft(2, '0')}-${s.date.day.toString().padLeft(2, '0')}';
      dateCounts[key] = (dateCounts[key] ?? 0) + 1;
    }

    final weeks = (daysToShow / 7).ceil();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workout Frequency (Last 10 Weeks)',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${summaries.length} total',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
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
                        boxColor = Theme.of(context).dividerColor
                            .withValues(alpha: 0.2);
                      } else if (count == 1) {
                        boxColor = Colors.green.shade400;
                      } else {
                        boxColor = Colors.green.shade700;
                      }

                      return Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
