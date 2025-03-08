import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> exportTimers() async {
    final String timersJson =
        json.encode(_timers.map((timer) => timer.toJson()).toList());
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/timers.json');
    await file.writeAsString(timersJson);
  }

  Future<void> importTimers() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final timersJson = await file.readAsString();
      final List<dynamic> timersList = json.decode(timersJson);
      _timers = timersList
          .map((timer) => TimerModel.fromJson(timer as Map<String, dynamic>))
          .toList();
      saveTimers();
      notifyListeners();
    }
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
      default:
        return duration.inMinutes; // Default to minutes
    }
  }
}
