import 'package:flutter/material.dart';

import '../../../analytics/domain/daily_workout_summary.dart';
import '../../../common/presentation/widgets/widgets.dart';

enum ActivityTimeRange() {
  week,
  month,
  quarter,
}

class const ActivityTrendsSection({
  super.key,
  required final ActivityTimeRange selectedTimeRange,
  required final ValueChanged<ActivityTimeRange> onRangeChanged,
  final VoidCallback? onAnalyticsTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onAnalyticsTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Activity Trends',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SegmentedButton<ActivityTimeRange>(
            segments: const [
              ButtonSegment(value: ActivityTimeRange.week, label: Text('Week')),
              ButtonSegment(
                value: ActivityTimeRange.month,
                label: Text('Month'),
              ),
              ButtonSegment(
                value: ActivityTimeRange.quarter,
                label: Text('Quarter'),
              ),
            ],
            selected: {selectedTimeRange},
            onSelectionChanged: (newSelection) =>
                onRangeChanged(newSelection.first),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              textStyle: WidgetStateProperty.all(textTheme.labelSmall),
            ),
          ),
        ],
      ),
    );
  }
}

class const ActivityTrendsCard({
  super.key,
  required final ActivityTimeRange selectedTimeRange,
  required final int timeOffset,
  required final String periodLabel,
  required final List<DailyWorkoutSummary> workoutHistory,
  required final VoidCallback onPrevious,
  required final VoidCallback onNext,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous period',
                onPressed: onPrevious,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    periodLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next period',
                onPressed: onNext,
              ),
            ],
          ),
          const Divider(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: switch (selectedTimeRange) {
                ActivityTimeRange.week => _WeekView(
                  summaries: workoutHistory,
                  timeOffset: timeOffset,
                ),
                ActivityTimeRange.month => _MonthView(
                  summaries: workoutHistory,
                  timeOffset: timeOffset,
                ),
                ActivityTimeRange.quarter => _QuarterView(
                  summaries: workoutHistory,
                  timeOffset: timeOffset,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class const _WeekView({
  required final List<DailyWorkoutSummary> summaries,
  required final int timeOffset,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final now = DateTime.now();
    final targetWeekStart = now
        .add(Duration(days: timeOffset * 7))
        .subtract(Duration(days: now.weekday - 1));
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayDate = DateTime(
          targetWeekStart.year,
          targetWeekStart.month,
          targetWeekStart.day + index,
        );
        final hasWorkout = summaries.any(
          (s) =>
              s.date.year == dayDate.year &&
              s.date.month == dayDate.month &&
              s.date.day == dayDate.day,
        );

        return Column(
          children: [
            Text(
              days[index],
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            Semantics(
              label:
                  '${dayNames[index]}: ${hasWorkout ? "Completed workout" : "Rest day"}',
              child: Container(
                width: 40,
                height: 50,
                decoration: BoxDecoration(
                  color: hasWorkout
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: hasWorkout
                    ? Icon(Icons.check, size: 20, color: colorScheme.onPrimary)
                    : null,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class const _MonthView({
  required final List<DailyWorkoutSummary> summaries,
  required final int timeOffset,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final now = DateTime.now();
    final targetMonth = DateTime(now.year, now.month + timeOffset);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (weekIndex) {
        final startDay = weekIndex * 7 + 1;
        final endDay = (weekIndex == 3) ? 31 : (weekIndex + 1) * 7;

        final count = summaries.where((s) {
          return s.date.year == targetMonth.year &&
              s.date.month == targetMonth.month &&
              s.date.day >= startDay &&
              s.date.day <= endDay;
        }).length;

        return Column(
          children: [
            Text(
              'W${weekIndex + 1}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label: 'Week ${weekIndex + 1}: $count workouts',
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: count > 0
                      ? colorScheme.primaryContainer.withValues(alpha: 0.4)
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count workouts',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class const _QuarterView({
  required final List<DailyWorkoutSummary> summaries,
  required final int timeOffset,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final now = DateTime.now();
    final currentQuarter = ((now.month - 1) ~/ 3) + 1;
    final targetQuarter = currentQuarter + timeOffset;
    final startMonth = (targetQuarter - 1) * 3 + 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(3, (index) {
        final m = startMonth + index;
        const monthNames = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final monthLabel = monthNames[(m - 1) % 12];
        final count = summaries
            .where((s) => s.date.month == m && s.date.year == now.year)
            .length;

        return Column(
          children: [
            Text(
              monthLabel,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label: '$monthLabel: $count sessions',
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count sessions',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
