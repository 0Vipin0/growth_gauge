import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/analytics_enums.dart';
import '../../domain/personal_record.dart';

/// Card displaying an earned Personal Record badge with details.
class const PrBadgeCard({super.key, required final PersonalRecord record, final String? exerciseName}) extends StatelessWidget {
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
    final colorScheme = theme.colorScheme;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events,
              color: colorScheme.onTertiaryContainer,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseName ?? record.exerciseId,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_formatPrType(record.prType)} • ${record.achievedAt.year}-${record.achievedAt.month.toString().padLeft(2, '0')}-${record.achievedAt.day.toString().padLeft(2, '0')}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatValue(record.prType, record.value),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
