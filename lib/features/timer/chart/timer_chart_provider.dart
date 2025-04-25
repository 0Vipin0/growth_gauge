import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/model.dart';
import 'duration_interval.dart';

class TimerChartProvider extends ChangeNotifier {
  List<BarChartGroupData> barGroups = [];
  bool isProcessed = false;
  late TimerModel _timer;
  late DurationInterval _interval;

  void processDataForChart(TimerModel timer, DurationInterval interval) {
    isProcessed = false;
    _timer = timer;
    _interval = interval;
    if (_timer.logs.isEmpty) {
      barGroups = [];
      return;
    }

    final Map<String, Duration> dailyDurations = {};
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

    final List<TimerLog> timerLogs = timer.logs;
    for (final TimerLog log in timerLogs) {
      if (log.timestamp.isAfter(sevenDaysAgo)) {
        final String dateKey = DateFormat('yyyy-MM-dd').format(log.timestamp);
        dailyDurations[dateKey] = log.interval;
      }
    }

    barGroups = generateBarGroups(dailyDurations, sevenDaysAgo, now, _interval);
    isProcessed = true;
    notifyListeners();
  }

  List<BarChartGroupData> generateBarGroups(
    Map<String, Duration> dailyDurations,
    DateTime startDate,
    DateTime endDate,
    DurationInterval interval,
  ) {
    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < 7; i++) {
      final DateTime date = startDate.add(Duration(days: i + 1));
      final String dateKey = DateFormat('yyyy-MM-dd').format(date);
      final Duration totalDuration = dailyDurations[dateKey] ?? Duration.zero;

      final double yValue = _getDurationInInterval(totalDuration, interval);

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: yValue, color: Colors.blue, width: 22),
          ],
        ),
      );
    }
    return groups;
  }

  double _getDurationInInterval(Duration duration, DurationInterval interval) {
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

  String getDayOfWeek(int index) {
    final DateTime now = DateTime.now();
    final DateTime date = now.subtract(Duration(days: 7 - 1 - index));
    return DateFormat('E').format(date);
  }

  String getChartTitle(DurationInterval interval) {
    return 'Total Time Spent (Last 7 Days) in ${interval.getUnitLabel()}';
  }
}
