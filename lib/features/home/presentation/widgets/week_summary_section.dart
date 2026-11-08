import 'package:flutter/material.dart';

import '../../../analytics/domain/calorie_calculator.dart';
import '../../../analytics/domain/daily_workout_summary.dart';
import '../../../common/presentation/widgets/widgets.dart';

class const WeekSummarySection({
    super.key,
    required final bool isDesktop,
    required final List<DailyWorkoutSummary> summaries,
    final VoidCallback? onDetailsTap,
    final int targetCalories = 3500,
    final double userWeightKg = 75.0,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));

    final weekSummaries = summaries
        .where((s) => !s.date.isBefore(startOfWeek))
        .toList();

    final totalActiveSeconds = weekSummaries.fold<int>(
      0,
      (sum, item) => sum + item.activeSeconds,
    );
    final hours = totalActiveSeconds ~/ 3600;
    final minutes = (totalActiveSeconds % 3600) ~/ 60;
    final activeTimeString = '${hours}h ${minutes}m';
    final workoutsCount = weekSummaries.length.toString();
    final burnedCalories = weekSummaries.calculateTotalCalories(
      userWeightKg: userWeightKg,
    );

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
            AppButton.ghost(label: 'Details', onPressed: onDetailsTap),
          ],
        ),
        const SizedBox(height: 12),
        if (isDesktop)
          _WeekSummaryDesktopGrid(
            activeTime: activeTimeString,
            workouts: workoutsCount,
            burnedCalories: burnedCalories,
            targetCalories: targetCalories,
          )
        else
          _WeekSummaryMobileStack(
            activeTime: activeTimeString,
            workouts: workoutsCount,
            burnedCalories: burnedCalories,
            targetCalories: targetCalories,
          ),
      ],
    );
  }
}

class const _WeekSummaryDesktopGrid({
    required final String activeTime,
    required final String workouts,
    required final int burnedCalories,
    required final int targetCalories,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: CaloriesCard(
              burnedCalories: burnedCalories,
              targetCalories: targetCalories,
            ),
          ),
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
    required final int burnedCalories,
    required final int targetCalories,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CaloriesCard(
          burnedCalories: burnedCalories,
          targetCalories: targetCalories,
        ),
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

class const CaloriesCard({
    super.key,
    final int burnedCalories = 0,
    final int targetCalories = 3500,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final progress = targetCalories > 0
        ? (burnedCalories / targetCalories).clamp(0.0, 1.0)
        : 0.0;
    final percentageString = '${(progress * 100).round()}%';
    final caloriesString = burnedCalories.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

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
                caloriesString,
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
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: colorScheme.primary,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                percentageString,
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
