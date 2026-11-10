import 'package:flutter/material.dart';

import '../../../analytics/domain/daily_workout_summary.dart';
import '../../../common/presentation/widgets/widgets.dart';

class const ActivityTrendsCard({
    super.key,
    required final List<DailyWorkoutSummary> workoutHistory,
    final VoidCallback? onAnalyticsTap,
    final bool showCount = false,
    final bool isDesktop = false,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onAnalyticsTap,
      child: AppCard(
        padding: EdgeInsets.all(isDesktop ? 28 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Activity Trends',
                      style:
                          (isDesktop
                                  ? textTheme.titleLarge
                                  : textTheme.titleMedium)
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                    ),
                    if (isDesktop) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'This Week',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (onAnalyticsTap != null)
                  TextButton.icon(
                    onPressed: onAnalyticsTap,
                    icon: const Icon(Icons.show_chart, size: 18),
                    label: const Text('Analytics'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            _WeekView(
              summaries: workoutHistory,
              showCount: showCount,
              isDesktop: isDesktop,
            ),
          ],
        ),
      ),
    );
  }
}

class const _WeekView({
    required final List<DailyWorkoutSummary> summaries,
    required final bool showCount,
    final bool isDesktop = false,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final now = DateTime.now();
    final targetWeekStart = now.subtract(Duration(days: now.weekday - 1));
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return Row(
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayDate = DateTime(
          targetWeekStart.year,
          targetWeekStart.month,
          targetWeekStart.day + index,
        );

        final dayWorkoutsCount = summaries
            .where(
              (s) =>
                  s.date.year == dayDate.year &&
                  s.date.month == dayDate.month &&
                  s.date.day == dayDate.day,
            )
            .length;

        final hasWorkout = dayWorkoutsCount > 0;
        final isToday =
            now.year == dayDate.year &&
            now.month == dayDate.month &&
            now.day == dayDate.day;

        final formattedDate =
            '${dayDate.day.toString().padLeft(2, '0')}/${dayDate.month.toString().padLeft(2, '0')}';

        return Column(
          children: [
            Text(
              days[index],
              style: textTheme.bodySmall?.copyWith(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formattedDate,
              style: textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label:
                  '${dayNames[index]} $formattedDate: ${hasWorkout ? "$dayWorkoutsCount workouts completed" : "Rest day"}',
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isDesktop ? 56 : 42,
                height: isDesktop ? 62 : 50,
                decoration: BoxDecoration(
                  color: hasWorkout
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: isToday
                      ? Border.all(color: colorScheme.primary, width: 2)
                      : null,
                  boxShadow: (isDesktop && isToday)
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: hasWorkout
                    ? (showCount
                          ? Text(
                              '$dayWorkoutsCount',
                              style:
                                  (isDesktop
                                          ? textTheme.titleMedium
                                          : textTheme.bodyMedium)
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onPrimary,
                                      ),
                            )
                          : Icon(
                              Icons.check,
                              size: isDesktop ? 24 : 20,
                              color: colorScheme.onPrimary,
                            ))
                    : null,
              ),
            ),
          ],
        );
      }),
    );
  }
}
