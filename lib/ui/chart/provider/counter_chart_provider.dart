import 'package:clock/clock.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import 'abstract_chart_provider.dart';

class CounterChartProvider extends AbstractChartProvider<CounterModel> {
  bool isProcessed = false;

  @override
  List<BarChartGroupData> processDataForChart(CounterModel counter) {
    isProcessed = false;

    final Map<String, int> dailyCounts = {};
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

    for (final CounterLog log in counter.logs) {
      if (log.timestamp.isAfter(sevenDaysAgo)) {
        final String dateKey = DateFormat('yyyy-MM-dd').format(log.timestamp);
        dailyCounts[dateKey] = (dailyCounts[dateKey] ?? 0) + 1;
      }
    }

    return _generateBarGroups(dailyCounts, sevenDaysAgo, now);
  }

  List<BarChartGroupData> _generateBarGroups(
    Map<String, dynamic> dailyCounts,
    DateTime startDate,
    DateTime endDate,
  ) {
    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < 7; i++) {
      final DateTime date = startDate.add(Duration(days: i + 1));
      final String dateKey = DateFormat('yyyy-MM-dd').format(date);
      final int count = (dailyCounts[dateKey] ?? 0) as int;

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
    isProcessed = true;
    return groups;
  }

  @override
  String getDayOfWeek(int index) {
    final DateTime now = clock.now();
    final DateTime date = now.subtract(Duration(days: 7 - 1 - index));
    return DateFormat('E').format(date);
  }
}
