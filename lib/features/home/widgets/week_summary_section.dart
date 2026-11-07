import 'package:flutter/material.dart';

import '../../analytics/domain/daily_workout_summary.dart';

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
            TextButton(
              onPressed: () {},
              child: Text(
                'Details',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
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
                  child: StatCard(
                    icon: Icons.timer_outlined,
                    title: 'Active Time',
                    value: activeTime,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: StatCard(
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
              child: StatCard(
                icon: Icons.timer_outlined,
                title: 'Active Time',
                value: activeTime,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
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

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
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

class const StatCard({
  super.key,
  required final IconData icon,
  required final String title,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
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
