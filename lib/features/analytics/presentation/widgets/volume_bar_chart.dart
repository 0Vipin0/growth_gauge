import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/muscle_volume_stat.dart';

/// Renders a weekly volume breakdown bar chart using fl_chart.
class const VolumeBarChart({
  super.key,
  required final List<MuscleVolumeStat> stats,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(
          child: Text(
            'No volume data logged yet.',
            style: TextStyle(color: Colors.grey),
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

    final maxVolume = displayEntries.fold<double>(
      0.0,
      (max, e) => e.value > max ? e.value : max,
    );
    final maxY = maxVolume > 0 ? maxVolume * 1.2 : 100.0;

    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < displayEntries.length; i++) {
      final entry = displayEntries[i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: entry.value,
              color: Theme.of(context).colorScheme.primary,
              width: 16,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }

    final accessibleSummary = displayEntries
        .map((entry) => '${entry.key}: ${entry.value.round()} kilograms')
        .join(', ');

    return Semantics(
      container: true,
      label: 'Weekly volume by muscle group. $accessibleSummary.',
      child: ExcludeSemantics(
        child: AspectRatio(
          aspectRatio: 1.6,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Volume by Muscle (kg)',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        barGroups: barGroups,
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(),
                          rightTitles: const AxisTitles(),
                          topTitles: const AxisTitles(),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final idx = value.toInt();
                                if (idx < 0 || idx >= displayEntries.length) {
                                  return const SizedBox.shrink();
                                }
                                final name = displayEntries[idx].key;
                                final shortName = name.length > 5
                                    ? name.substring(0, 5)
                                    : name;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    shortName,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
