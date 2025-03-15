import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

import '../chart/chart.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class TimerListProvider with ChangeNotifier {
  final TimerRepository repository;
  List<TimerModel> _timers = [];

  TimerListProvider({required this.repository}) {
    _loadTimers();
  }

  List<TimerModel> get timers => _timers;

  Future<void> _loadTimers() async {
    _timers = await repository.getTimers();
    notifyListeners();
  }

  Future<void> saveTimers() async {
    await repository.saveTimers(_timers);
  }

  Future<void> clearTimers() async {
    _timers = [];
    saveTimers();
    notifyListeners();
  }

  TimerModel getTimer(TimerModel newTimer) {
    return _timers.firstWhere((timer) => timer.id == newTimer.id);
  }

  void updateTimer(TimerModel newTimer) {
    TimerModel timer = getTimer(newTimer)
        .copyWith(interval: newTimer.interval, logs: newTimer.logs);
    for (int i = 0; i < _timers.length; i++) {
      if (timer.id == _timers[i].id) {
        _timers[i] = timer;
      }
    }
    saveTimers();
    notifyListeners();
  }

  void addTimer(TimerModel newTimer) {
    _timers.add(newTimer);
    saveTimers();
    notifyListeners();
  }

  void removeTimer(TimerModel timer) {
    _timers.remove(timer);
    saveTimers();
    notifyListeners();
  }

  void importTimersFromData(List<TimerModel> importedTimers) {
    _timers = importedTimers;
    saveTimers();
    notifyListeners();
  }

  Map<DateTime, int> extractCountsByDayPerDurationInterval(
      TimerModel timer, DurationInterval interval) {
    Map<DateTime, int> dailyIntervalCounts = {};

    if (timer.logs.isNotEmpty) {
      final logsByDate = groupBy(timer.logs, (TimerLog log) {
        return DateTime(
            log.timestamp.year, log.timestamp.month, log.timestamp.day);
      });
      logsByDate.forEach((date, logs) {
        Duration totalDurationForDay = Duration.zero;
        totalDurationForDay += logs.last.interval;

        int intervalCount =
            _convertDurationToIntervalCount(totalDurationForDay, interval);
        dailyIntervalCounts[date] =
            (dailyIntervalCounts[date] ?? 0) + intervalCount;
      });
    }

    return dailyIntervalCounts;
  }

  int _convertDurationToIntervalCount(
      Duration duration, DurationInterval interval) {
    switch (interval) {
      case DurationInterval.tenSeconds:
        return duration.inSeconds ~/ 10;
      case DurationInterval.thirtySeconds:
        return duration.inSeconds ~/ 30;
      case DurationInterval.minute:
        return duration.inMinutes;
      case DurationInterval.twoMinutes:
        return duration.inMinutes ~/ 2;
    }
  }

  String convertToCSV() {
    List<FlatTimerModel> flattenedDataList = [];
    for (TimerModel timer in _timers) {
      for (TimerLog log in timer.logs) {
        flattenedDataList.add(FlatTimerModel.fromTimerModel(timer, log));
      }
    }
    return convertFlattenedListToCsv(flattenedDataList);
  }

  String convertFlattenedListToCsv(List<FlatTimerModel> flattenedDataList) {
    List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Name',
      'Interval',
      'Description',
      'Log Action',
      'Log Timestamp',
      'Log Interval'
    ]);

    for (FlatTimerModel flattenedData in flattenedDataList) {
      rows.add(flattenedData.toCsvRow());
    }

    return const ListToCsvConverter().convert(rows);
  }
}
