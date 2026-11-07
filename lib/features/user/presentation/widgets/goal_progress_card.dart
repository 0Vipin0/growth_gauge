import 'package:flutter/material.dart';

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

  Color _statusColor(GoalStatus status) {
    switch (status) {
      case GoalStatus.active:
        return Colors.blue;
      case GoalStatus.achieved:
        return Colors.green;
      case GoalStatus.abandoned:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = goal.progressPercent;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                          color: Colors.grey.shade600,
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
                  backgroundColor: _statusColor(goal.status),
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
                backgroundColor: theme.dividerColor.withValues(alpha: 0.2),
                color: goal.isAchieved
                    ? Colors.green
                    : theme.colorScheme.primary,
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
                    color: goal.isAchieved
                        ? Colors.green
                        : theme.colorScheme.primary,
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
                    TextButton.icon(
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Update'),
                      onPressed: onUpdateProgress,
                    ),
                  if (onComplete != null)
                    TextButton.icon(
                      icon: const Icon(Icons.check, size: 16),
                      label: const Text('Complete'),
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
