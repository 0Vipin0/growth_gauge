import 'package:flutter/material.dart';

import '../../domain/analytics_enums.dart';
import '../../domain/personal_record.dart';

/// Card displaying an earned Personal Record badge with details.
class PrBadgeCard extends StatelessWidget {
  final PersonalRecord record;
  final String? exerciseName;

  const PrBadgeCard({super.key, required this.record, this.exerciseName});

  String _formatPrType(PrType type) {
    switch (type) {
      case PrType.maxWeight:
        return 'Max Weight';
      case PrType.estimated1Rm:
        return 'Est. 1RM';
      case PrType.maxRepsAtWeight:
        return 'Max Reps';
      case PrType.maxVolumeSet:
        return 'Set Volume';
      case PrType.maxVolumeSession:
        return 'Session Volume';
    }
  }

  String _formatValue(PrType type, double value) {
    switch (type) {
      case PrType.maxWeight:
      case PrType.estimated1Rm:
        return '${value.toStringAsFixed(1)} kg';
      case PrType.maxRepsAtWeight:
        return '${value.toInt()} reps';
      case PrType.maxVolumeSet:
      case PrType.maxVolumeSession:
        return '${value.toStringAsFixed(0)} kg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber.withValues(alpha: 0.2),
          child: const Icon(Icons.emoji_events, color: Colors.amber),
        ),
        title: Text(
          exerciseName ?? record.exerciseId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${_formatPrType(record.prType)} • ${record.achievedAt.year}-${record.achievedAt.month.toString().padLeft(2, '0')}-${record.achievedAt.day.toString().padLeft(2, '0')}',
        ),
        trailing: Text(
          _formatValue(record.prType, record.value),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
