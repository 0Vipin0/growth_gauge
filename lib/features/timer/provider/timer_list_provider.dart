import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../notification/notification_service.dart';
import '../chart/chart.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class TimerListProvider with ChangeNotifier {
  final TimerRepository repository;
  final NotificationService notificationService;
  List<TimerModel> _timers = [];

  TimerListProvider(
      {required this.repository, required this.notificationService}) {
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
    final TimerModel timer = getTimer(
      newTimer,
    ).copyWith(interval: newTimer.interval, logs: newTimer.logs);
    for (int i = 0; i < _timers.length; i++) {
      if (timer.id == _timers[i].id) {
        _timers[i] = timer;
      }
    }

    if (newTimer.target != timer.target) {
      final log = TimerLog(
        id: DateTime.now().toIso8601String(),
        action: 'Target updated to ${newTimer.target?.inMinutes} minutes',
        timestamp: DateTime.now(),
        interval: Duration.zero,
      );
      final modifiableLogs = List<TimerLog>.from(timer.logs);
      modifiableLogs.add(log);
      final updatedTimer = timer.copyWith(logs: modifiableLogs);
      for (int i = 0; i < _timers.length; i++) {
        if (updatedTimer.id == _timers[i].id) {
          _timers[i] = updatedTimer;
        }
      }
    }

    // Check if the target is reached
    if (timer.target != null && timer.interval >= timer.target!) {
      // Trigger notification
      _triggerNotification(
        title: 'Target Reached!',
        body:
            'Timer "${timer.name}" has reached its target duration of ${timer.target!.inMinutes} minutes.',
      );
    }

    saveTimers();
    notifyListeners();
  }

  void _triggerNotification({required String title, required String body}) {
    notificationService.scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
      scheduledTime:
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
    );
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
    TimerModel timer,
    DurationInterval interval,
  ) {
    final Map<DateTime, int> dailyIntervalCounts = {};

    if (timer.logs.isNotEmpty) {
      final logsByDate = groupBy(timer.logs, (TimerLog log) {
        return DateTime(
          log.timestamp.year,
          log.timestamp.month,
          log.timestamp.day,
        );
      });
      logsByDate.forEach((date, logs) {
        Duration totalDurationForDay = Duration.zero;
        totalDurationForDay += logs.last.interval;

        final int intervalCount = _convertDurationToIntervalCount(
          totalDurationForDay,
          interval,
        );
        dailyIntervalCounts[date] =
            (dailyIntervalCounts[date] ?? 0) + intervalCount;
      });
    }

    return dailyIntervalCounts;
  }

  int _convertDurationToIntervalCount(
    Duration duration,
    DurationInterval interval,
  ) {
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
    final List<FlatTimerModel> flattenedDataList = [];
    for (final TimerModel timer in _timers) {
      for (final TimerLog log in timer.logs) {
        flattenedDataList.add(FlatTimerModel.fromTimerModel(timer, log));
      }
    }
    return convertFlattenedListToCsv(flattenedDataList);
  }

  String convertFlattenedListToCsv(List<FlatTimerModel> flattenedDataList) {
    final List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Name',
      'Interval',
      'Description',
      'Target',
      'Log Action',
      'Log Timestamp',
      'Log Interval',
    ]);

    for (final FlatTimerModel flattenedData in flattenedDataList) {
      rows.add(flattenedData.toCsvRow());
    }

    return const ListToCsvConverter().convert(rows);
  }
}
