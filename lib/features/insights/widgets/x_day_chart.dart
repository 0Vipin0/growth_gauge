import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../model/daily_aggregate.dart';

class XDayChart extends StatelessWidget {
  final List<DailyAggregate> data;

  const XDayChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final spots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.total)).toList();
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
              final index = v.toInt();
              if (index >= 0 && index < data.length) {
                final d = data[index].day;
                return Text('${d.month}/${d.day}');
              }
              return const Text('');
            })),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          lineBarsData: [LineChartBarData(spots: spots)],
        ),
      ),
    );
  }
}
