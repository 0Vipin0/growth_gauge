import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'counter_model.dart';

class CounterChangeGraph extends StatelessWidget {
  final CounterModel counter;

  const CounterChangeGraph({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _generateDataPoints(),
            isCurved: true,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: _getTitlesData(),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 2),
            left: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        minX: 0,
        maxX: 6,
        minY: _calculateMinY() - 1,
        maxY: _calculateMaxY() + 1,
      ),
    );
  }

  List<FlSpot> _generateDataPoints() {
    final List<FlSpot> dataPoints = [];
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: 6 - i));
      final dateStr = dateFormat.format(day);

      int countForDay = counter.logs
          .where((log) => dateFormat.format(log.timestamp) == dateStr)
          .fold(0, (sum, log) => sum + 1);

      dataPoints.add(FlSpot(i.toDouble(), countForDay.toDouble()));
    }

    return dataPoints;
  }

  double _calculateMinY() {
    final dataPoints = _generateDataPoints();
    return dataPoints.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
  }

  double _calculateMaxY() {
    final dataPoints = _generateDataPoints();
    return dataPoints.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
  }

  FlTitlesData _getTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final DateTime now = DateTime.now();
            final DateFormat dateFormat = DateFormat('E');
            final DateTime date =
                now.subtract(Duration(days: 6 - value.toInt()));
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(dateFormat.format(date)),
            );
          },
          interval: 1,
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
        ),
      ),
    );
  }
}
