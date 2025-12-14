import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BaseChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final String Function(int) dayLabel;
  final double yAxisInterval;

  const BaseChartWidget({
    super.key,
    required this.barGroups,
    required this.dayLabel,
    required this.yAxisInterval,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = barGroups
            .map((group) => group.barRods.first.toY)
            .fold(0.0, (max, y) => y > max ? y : max) +
        5;
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      dayLabel(value.toInt()),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value % 1 == 0
                        ? value.toInt().toString()
                        : '', // Show only integer values
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12),
                  );
                },
                reservedSize: 28, // Adjust for label width
                interval: yAxisInterval, // Calculate interval dynamically
              ),
            ),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(show: false),
          barGroups: barGroups,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.toY.toInt().toString(),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
