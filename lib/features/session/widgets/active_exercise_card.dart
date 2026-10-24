import 'package:flutter/material.dart';

import '../domain/execution_set.dart';

class const ActiveExerciseCard({
    super.key,
    required final String exerciseName,
    required final ExecutionSet? currentSet,
    required final bool isBusy,
    required final String activeDurationText,
    required final String elapsedDurationText,
    required final ValueChanged<ExecutionSet> onRecord,
    required final ValueChanged<ExecutionSet> onEditTarget,
    required final ValueChanged<ExecutionSet> onDelete,
    required final ValueChanged<ExecutionSet> onSkip,
    required final VoidCallback onNext,
    required final VoidCallback onPrevious,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Timers Row (Active & Elapsed)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TimerMetric(label: 'Active', value: activeDurationText),
              Container(
                height: 24,
                width: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              _TimerMetric(label: 'Elapsed', value: elapsedDurationText),
            ],
          ),
          const Divider(height: 24),

          // Highlighted Current Set Badge & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentSet != null
                      ? 'ACTIVE SET ${currentSet!.setNumber}'
                      : 'SET',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              if (currentSet != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentSet!.status.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Exercise Icon with Glow
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.25),
                  blurRadius: 25,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Icon(
              Icons.fitness_center,
              size: 36,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),

          // Exercise Title
          Text(
            exerciseName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Prominent Target Details Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'TARGET PRESCRIPTION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _buildTargetSummary(currentSet),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Set Navigation Controls (Back / Forward)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: isBusy ? null : onPrevious,
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                tooltip: 'Previous set',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Navigate Sets',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
              IconButton.outlined(
                onPressed: isBusy ? null : onNext,
                icon: const Icon(Icons.arrow_forward_ios, size: 18),
                tooltip: 'Next set',
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Action Buttons (Log Set, Edit Target, Skip, Delete)
          if (currentSet != null) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: isBusy ? null : () => onRecord(currentSet!),
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text('Log set'),
                ),
                OutlinedButton.icon(
                  onPressed: isBusy ? null : () => onEditTarget(currentSet!),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit target'),
                ),
                OutlinedButton.icon(
                  onPressed: isBusy ? null : () => onSkip(currentSet!),
                  icon: const Icon(Icons.skip_next, size: 16),
                  label: const Text('Skip'),
                ),
                OutlinedButton.icon(
                  onPressed: isBusy ? null : () => onDelete(currentSet!),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                  ),
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _buildTargetSummary(ExecutionSet? set) {
    if (set == null) return 'No set selected';
    final reps = set.targetReps != null
        ? '${set.targetReps} reps'
        : 'Time-based';
    final weight = set.targetWeight != null ? ' · ${set.targetWeight} kg' : '';
    final rest = set.plannedRestSeconds > 0
        ? ' · ${set.plannedRestSeconds}s rest'
        : '';
    return '$reps$weight$rest';
  }
}

class const _TimerMetric({required final String label, required final String value}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
