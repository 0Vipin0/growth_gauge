import 'package:flutter/material.dart';

import '../../../analytics/domain/daily_workout_summary.dart';
import '../../../common/presentation/widgets/widgets.dart';

class const WeekSummarySection({
  super.key,
  required final bool isDesktop,
  required final List<DailyWorkoutSummary> summaries,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekSummaries = summaries.where(
      (s) => s.date.isAfter(startOfWeek.subtract(const Duration(days: 1))),
    );

    final totalActiveSeconds = weekSummaries.fold<int>(
      0,
      (sum, item) => sum + item.activeSeconds,
    );
    final hours = totalActiveSeconds ~/ 3600;
    final minutes = (totalActiveSeconds % 3600) ~/ 60;
    final activeTimeString = '${hours}h ${minutes}m';
    final workoutsCount = weekSummaries.length.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'This Week',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            AppButton.ghost(label: 'Details', onPressed: () {}),
          ],
        ),
        const SizedBox(height: 12),
        if (isDesktop)
          _WeekSummaryDesktopGrid(
            activeTime: activeTimeString,
            workouts: workoutsCount,
          )
        else
          _WeekSummaryMobileStack(
            activeTime: activeTimeString,
            workouts: workoutsCount,
          ),
      ],
    );
  }
}

class const _WeekSummaryDesktopGrid({
  required final String activeTime,
  required final String workouts,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(flex: 3, child: CaloriesCard()),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: AppStatCard(
                    icon: Icons.timer_outlined,
                    title: 'Active Time',
                    value: activeTime,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: AppStatCard(
                    icon: Icons.fitness_center,
                    title: 'Workouts',
                    value: workouts,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _WeekSummaryMobileStack({
  required final String activeTime,
  required final String workouts,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CaloriesCard(),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: AppStatCard(
                icon: Icons.timer_outlined,
                title: 'Active Time',
                value: activeTime,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppStatCard(
                icon: Icons.fitness_center,
                title: 'Workouts',
                value: workouts,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class const CaloriesCard({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Calories Burned',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '3,240',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                'kcal',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: colorScheme.primary,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '85%',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
