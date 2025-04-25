import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../counter.dart';

class CounterChartProvider extends ChangeNotifier {
  List<BarChartGroupData> barGroups = [];
  bool isProcessed = false;
  late CounterModel _counter;

  void processDataForChart(CounterModel counter) {
    isProcessed = false;
    _counter = counter;
    if (_counter.logs.isEmpty) {
      barGroups = [];
      return;
    }

    final Map<String, int> dailyCounts = {};
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

    final List<CounterLog> countDateLogs = counter.logs;
    for (final CounterLog log in countDateLogs) {
      if (log.timestamp.isAfter(sevenDaysAgo)) {
        final String dateKey = DateFormat('yyyy-MM-dd').format(log.timestamp);
        dailyCounts[dateKey] = (dailyCounts[dateKey] ?? 0) + 1;
      }
    }

    barGroups = generateBarGroups(dailyCounts, sevenDaysAgo, now);
    isProcessed = true;
  }

  List<BarChartGroupData> generateBarGroups(
    Map<String, int> dailyCounts,
    DateTime startDate,
    DateTime endDate,
  ) {
    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < 7; i++) {
      final DateTime date = startDate.add(Duration(days: i + 1));
      final String dateKey = DateFormat('yyyy-MM-dd').format(date);
      final int count = dailyCounts[dateKey] ?? 0;

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.blue,
              width: 22,
            ),
          ],
        ),
      );
    }
    return groups;
  }

  String getDayOfWeek(int index) {
    final DateTime now = DateTime.now();
    final DateTime date = now.subtract(Duration(days: 7 - 1 - index));
    return DateFormat('E').format(date);
  }
}
