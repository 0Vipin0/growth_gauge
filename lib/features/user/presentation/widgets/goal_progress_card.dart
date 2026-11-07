import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/training_goal.dart';
import '../../domain/user_enums.dart';

/// Card displaying progress toward a training goal with status indicators.
class const GoalProgressCard({
    super.key,
    required final TrainingGoal goal,
    final VoidCallback? onUpdateProgress,
    final VoidCallback? onComplete,
    final VoidCallback? onAbandon,
    final VoidCallback? onDelete,
  }) extends StatelessWidget {
  String _formatType(GoalType type) {
    switch (type) {
      case GoalType.strength:
        return 'Strength';
      case GoalType.endurance:
        return 'Endurance';
      case GoalType.workoutFrequency:
        return 'Frequency';
      case GoalType.volume:
        return 'Volume';
      case GoalType.repetition:
        return 'Reps';
      case GoalType.duration:
        return 'Duration';
      case GoalType.distance:
        return 'Distance';
      case GoalType.bodyWeight:
        return 'Body Weight';
      case GoalType.custom:
        return 'Custom';
    }
  }

  Color _statusColor(GoalStatus status, ColorScheme colorScheme) {
    switch (status) {
      case GoalStatus.active:
        return colorScheme.primary;
      case GoalStatus.achieved:
        return Colors.green;
      case GoalStatus.abandoned:
        return colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final percent = goal.progressPercent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatType(goal.type),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    goal.status.name.toUpperCase(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  backgroundColor: _statusColor(goal.status, colorScheme),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            if (goal.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(goal.description, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: goal.isAchieved ? Colors.green : colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start: ${goal.startValue.toStringAsFixed(1)} ${goal.unit}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Current: ${goal.currentValue.toStringAsFixed(1)} ${goal.unit} (${(percent * 100).toInt()}%)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: goal.isAchieved ? Colors.green : colorScheme.primary,
                  ),
                ),
                Text(
                  'Target: ${goal.targetValue.toStringAsFixed(1)} ${goal.unit}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            if (goal.isActive) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onUpdateProgress != null)
                    AppButton.ghost(
                      label: 'Update',
                      icon: Icons.edit,
                      onPressed: onUpdateProgress,
                    ),
                  const SizedBox(width: 8),
                  if (onComplete != null)
                    AppButton.secondary(
                      label: 'Complete',
                      icon: Icons.check,
                      onPressed: onComplete,
                    ),
                  PopupMenuButton<String>(
                    onSelected: (val) {
                      if (val == 'abandon') onAbandon?.call();
                      if (val == 'delete') onDelete?.call();
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 'abandon',
                        child: Text('Abandon Goal'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          'Delete Goal',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
