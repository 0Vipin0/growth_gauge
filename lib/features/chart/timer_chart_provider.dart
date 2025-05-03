import 'package:clock/clock.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../timer/chart/duration_interval.dart';
import '../timer/model/model.dart';
import 'abstract_chart_provider.dart';

class TimerChartProvider extends AbstractChartProvider<TimerModel> {
  late DurationInterval interval;
  bool isProcessed = false;

  @override
  List<BarChartGroupData> processDataForChart(TimerModel timer) {
    isProcessed = false;
    if (timer.logs.isEmpty) {
      return [];
    }

    final Map<String, Duration> dailyDurations = {};
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

    for (final TimerLog log in timer.logs) {
      if (log.timestamp.isAfter(sevenDaysAgo)) {
        final String dateKey = DateFormat('yyyy-MM-dd').format(log.timestamp);
        dailyDurations[dateKey] = log.interval;
      }
    }

    return _generateBarGroups(dailyDurations, sevenDaysAgo, now);
  }

  List<BarChartGroupData> _generateBarGroups(
    Map<String, dynamic> dailyDurations,
    DateTime startDate,
    DateTime endDate,
  ) {
    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < 7; i++) {
      final DateTime date = startDate.add(Duration(days: i + 1));
      final String dateKey = DateFormat('yyyy-MM-dd').format(date);
      final Duration totalDuration =
          (dailyDurations[dateKey] ?? Duration.zero) as Duration;

      final double yValue = _getDurationInInterval(totalDuration);

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: yValue, color: Colors.blue, width: 22),
          ],
        ),
      );
    }
    isProcessed = true;
    return groups;
  }

  double _getDurationInInterval(Duration duration) {
    switch (interval) {
      case DurationInterval.tenSeconds:
        return duration.inSeconds / 10;
      case DurationInterval.thirtySeconds:
        return duration.inSeconds / 30;
      case DurationInterval.minute:
        return duration.inMinutes.toDouble();
      case DurationInterval.twoMinutes:
        return duration.inMinutes / 2.0;
    }
  }

  @override
  String getDayOfWeek(int index) {
    final DateTime now = clock.now();
    final DateTime date = now.subtract(Duration(days: 7 - 1 - index));
    return DateFormat('E').format(date);
  }
}
