import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../chart/chart.dart';
import '../model/model.dart';
import 'duration_interval.dart';

class ChartPage extends StatelessWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const ChartPage({
    super.key,
    required this.timer,
    required this.durationInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Exercise Counts - Last 7 Days',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Time Spent per ${durationInterval.getUnitLabel()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          Consumer<TimerChartProvider>(
            builder: (context, chartProvider, child) {
              chartProvider.interval = durationInterval;
              final barGroups = chartProvider.processDataForChart(timer);
              final maxY = barGroups
                      .map((group) => group.barRods.first.toY)
                      .fold(0.0, (max, y) => y > max ? y : max) +
                  5;

              return !chartProvider.isProcessed
                  ? const CircularProgressIndicator()
                  : BaseChartWidget(
                      barGroups: barGroups,
                      dayLabel: (value) => chartProvider.getDayOfWeek(value),
                      yAxisInterval: calculateYAxisInterval(maxY),
                    );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Days are based on the last 7 days.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static double calculateYAxisInterval(double maxY) {
    if (maxY <= 10) {
      return 1;
    } else if (maxY <= 50) {
      return 5;
    } else if (maxY <= 100) {
      return 10;
    } else {
      return 20; // Or some other logic for larger maxY values
    }
  }
}
