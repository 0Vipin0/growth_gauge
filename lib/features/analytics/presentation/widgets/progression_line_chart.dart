import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/exercise_set_metric.dart';

/// Renders a 1RM estimated progression curve using fl_chart.
class const ProgressionLineChart({
  super.key,
  required final List<ExerciseSetMetric> metrics,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final validMetrics = metrics
        .where((m) => m.estimated1Rm != null && m.estimated1Rm! > 0)
        .toList();

    if (validMetrics.isEmpty) {
      return AppCard(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Text(
              'No 1RM data recorded for this exercise yet.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      );
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < validMetrics.length; i++) {
      spots.add(FlSpot(i.toDouble(), validMetrics[i].estimated1Rm!));
    }

    final minY = validMetrics
        .map((m) => m.estimated1Rm!)
        .reduce((a, b) => a < b ? a : b);
    final maxY = validMetrics
        .map((m) => m.estimated1Rm!)
        .reduce((a, b) => a > b ? a : b);

    final padding = (maxY - minY) * 0.2;
    final chartMinY = (minY - padding).clamp(0.0, double.infinity);
    final chartMaxY = maxY + (padding == 0 ? 10.0 : padding);

    final first = validMetrics.first;
    final last = validMetrics.last;
    final accessibleSummary = validMetrics.length == 1
        ? 'One recorded set at ${first.estimated1Rm!.toStringAsFixed(1)} kilograms.'
        : '${validMetrics.length} recorded sets, from ${first.estimated1Rm!.toStringAsFixed(1)} kilograms to ${last.estimated1Rm!.toStringAsFixed(1)} kilograms.';

    return Semantics(
      container: true,
      label: 'Estimated one repetition maximum progression. $accessibleSummary',
      child: ExcludeSemantics(
        child: AspectRatio(
          aspectRatio: 1.6,
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated 1RM Progression (kg)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: chartMinY,
                      maxY: chartMaxY,
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: colorScheme.primary,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: colorScheme.primary.withValues(alpha: 0.15),
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) => Text(
                              '${value.toInt()}kg',
                              style: TextStyle(
                                fontSize: 10,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                        rightTitles: const AxisTitles(),
                        topTitles: const AxisTitles(),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: (validMetrics.length / 5).clamp(
                              1.0,
                              50.0,
                            ),
                            getTitlesWidget: (value, meta) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= validMetrics.length) {
                                return const SizedBox.shrink();
                              }
                              final date = validMetrics[idx].timestamp;
                              return Text(
                                '${date.month}/${date.day}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
