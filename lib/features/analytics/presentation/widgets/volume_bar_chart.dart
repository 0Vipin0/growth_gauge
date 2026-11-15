import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../chart/chart.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/muscle_volume_stat.dart';

/// Renders a weekly volume breakdown bar chart using BaseChartWidget.
class const VolumeBarChart({
  super.key,

  /// List of muscle volume statistics.
  required final List<MuscleVolumeStat> stats,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (stats.isEmpty) {
      return AppCard(
        child: SizedBox(
          height: 180,
          child: Center(
            child: Text(
              'No volume data logged yet.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      );
    }

    // Aggregate volume by muscle group
    final muscleTotals = <String, double>{};
    for (final s in stats) {
      muscleTotals[s.muscleGroup] =
          (muscleTotals[s.muscleGroup] ?? 0.0) + s.totalVolumeKg;
    }

    final entries = muscleTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final displayEntries = entries.take(6).toList();

    // Build bar groups for fl_chart
    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < displayEntries.length; i++) {
      final entry = displayEntries[i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: entry.value,
              color: colorScheme.primary,
              width: 16,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }

    // Calculate a dynamic y-axis interval based on max volume
    final maxVolume = displayEntries.fold<double>(
      0.0,
      (max, e) => e.value > max ? e.value : max,
    );
    final yAxisInterval = maxVolume > 0
        ? (maxVolume / 5).ceil().toDouble()
        : 20.0;

    final accessibleSummary = displayEntries
        .map((entry) => '${entry.key}: ${entry.value.round()} kilograms')
        .join(', ');

    return Semantics(
      container: true,
      label: 'Weekly volume by muscle group. $accessibleSummary.',
      child: ExcludeSemantics(
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Volume by Muscle (kg)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              BaseChartWidget(
                barGroups: barGroups,
                dayLabel: (index) {
                  if (index < 0 || index >= displayEntries.length) {
                    return '';
                  }
                  final name = displayEntries[index].key;
                  return name.length > 5 ? name.substring(0, 5) : name;
                },
                yAxisInterval: yAxisInterval,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
