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
    final workoutsCount = weekSummaries.length;

    final avgDurationMinutes = workoutsCount > 0
        ? (totalActiveSeconds ~/ 60) ~/ workoutsCount
        : 0;

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
              style: (isDesktop ? textTheme.titleLarge : textTheme.titleMedium)
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 16 : 12),
        if (isDesktop)
          _WeekSummaryDesktopGrid(
            activeTime: activeTimeString,
            workouts: workoutsCount.toString(),
            avgDuration: '${avgDurationMinutes}m',
            burnedCalories: burnedCalories,
            targetCalories: targetCalories,
            completedWorkouts: workoutsCount,
          )
        else
          _WeekSummaryMobileStack(
            activeTime: activeTimeString,
            workouts: workoutsCount.toString(),
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
  required final String avgDuration,
  required final int burnedCalories,
  required final int targetCalories,
  required final int completedWorkouts,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column 1: Calories Card
          Expanded(
            child: CaloriesCard(
              burnedCalories: burnedCalories,
              targetCalories: targetCalories,
              isDesktop: true,
            ),
          ),
          const SizedBox(width: 16),
          // Column 2: Side-by-side row for Active Time & Workouts (reduces height & removes vertical gap)
          Expanded(
            child: Row(
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
          ),
          const SizedBox(width: 16),
          // Column 3: Weekly Insights Card
          Expanded(
            child: _WeeklyInsightsCard(
              avgDuration: avgDuration,
              completedWorkouts: completedWorkouts,
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

class const _WeeklyInsightsCard({
  required final String avgDuration,
  required final int completedWorkouts,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    const weeklyGoalWorkouts = 4;
    final progressToGoal = (completedWorkouts / weeklyGoalWorkouts).clamp(
      0.0,
      1.0,
    );

    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Weekly Insights',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Avg. Session',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                avgDuration,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goal Pace',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$completedWorkouts/$weeklyGoalWorkouts sessions',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressToGoal,
              minHeight: 6,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class const CaloriesCard({
  super.key,
  final int burnedCalories = 0,
  final int targetCalories = 3500,
  final bool isDesktop = false,
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
      padding: EdgeInsets.all(isDesktop ? 28 : 24),
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
                    size: isDesktop ? 22 : 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Calories Burned',
                    style:
                        (isDesktop ? textTheme.bodyLarge : textTheme.bodyMedium)
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              SizedBox(height: isDesktop ? 16 : 12),
              Text(
                caloriesString,
                style:
                    (isDesktop
                            ? textTheme.headlineLarge
                            : textTheme.headlineMedium)
                        ?.copyWith(
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
                width: isDesktop ? 100 : 80,
                height: isDesktop ? 100 : 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: isDesktop ? 10 : 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: colorScheme.primary,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                percentageString,
                style:
                    (isDesktop ? textTheme.titleLarge : textTheme.titleMedium)
                        ?.copyWith(
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
