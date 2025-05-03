import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BaseChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final List<String> dayLabels;

  const BaseChartWidget({
    super.key,
    required this.barGroups,
    required this.dayLabels,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: barGroups,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(dayLabels[value.toInt()]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
