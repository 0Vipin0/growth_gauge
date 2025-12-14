import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../notification/notification_service.dart';
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
  List<TimerModel> _filteredTimers = [];

  List<TimerModel> get filteredTimers =>
      _filteredTimers.isEmpty ? _timers : _filteredTimers;

  void filterTimersByTags(List<String> tags) {
    if (tags.isEmpty) {
      _filteredTimers = [];
    } else {
      _filteredTimers = _timers
          .where((timer) =>
              timer.tags != null &&
              timer.tags!.any((tag) => tags.contains(tag)))
          .toList();
    }
    notifyListeners();
  }

  void filterTimersByText(String query) {
    if (query.isEmpty) {
      _filteredTimers = [];
    } else {
      _filteredTimers = _timers.where((timer) {
        final lowerQuery = query.toLowerCase();
        return timer.name.toLowerCase().contains(lowerQuery) ||
            timer.description.toLowerCase().contains(lowerQuery) ||
            (timer.target?.inMinutes.toString().contains(lowerQuery) ??
                false) ||
            timer.interval.inSeconds.toString().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  List<String> getAllTags() {
    final Set<String> tags = {};
    for (final timer in _timers) {
      if (timer.tags != null) {
        tags.addAll(timer.tags!);
      }
    }
    return tags.toList();
  }

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
    TimerModel timer = getTimer(newTimer);

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

    timer = getTimer(newTimer).copyWith(
      interval: newTimer.interval,
      target: newTimer.target ?? timer.target,
      logs: newTimer.logs,
      tags: newTimer.tags,
    );
    for (int i = 0; i < _timers.length; i++) {
      if (timer.id == _timers[i].id) {
        _timers[i] = timer;
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
        sound: 'assets/sounds/simple_notification.mp3');
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

  void sortTimersByName() {
    _timers.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortTimersByInterval() {
    _timers.sort((a, b) => a.interval.compareTo(b.interval));
    notifyListeners();
  }

  final List<String> _selectedTags = [];

  List<String> get selectedTags => _selectedTags;

  void toggleTagSelection(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    filterTimersByTags(_selectedTags);
    notifyListeners();
  }

  void clearSelectedTags() {
    _selectedTags.clear();
    filterTimersByTags(_selectedTags);
    notifyListeners();
  }

  void addTagToTimer(TimerModel timer, String tag) {
    if (!timer.tags!.contains(tag)) {
      final updatedTags = List<String>.from(timer.tags ?? [])..add(tag);
      updateTimer(timer.copyWith(tags: updatedTags));
    }
  }

  void removeTagFromTimer(TimerModel timer, String tag) {
    final updatedTags = List<String>.from(timer.tags ?? [])..remove(tag);
    updateTimer(timer.copyWith(tags: updatedTags));
  }

  void updateTagsForTimer(TimerModel timer, List<String> updatedTags) {
    updateTimer(timer.copyWith(tags: updatedTags));
  }

  List<String> _updatedTags = [];

  List<String> get updatedTags => _updatedTags;

  void initializeTags(List<String>? tags) {
    _updatedTags = List<String>.from(tags ?? []);
    notifyListeners();
  }

  void addTag(String tag) {
    if (!_updatedTags.contains(tag)) {
      _updatedTags.add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _updatedTags.remove(tag);
    notifyListeners();
  }

  void saveTags(TimerModel timer) {
    final TimerModel updatedTimer = timer.copyWith(tags: _updatedTags);
    updateTimer(updatedTimer);
    _updatedTags = [];
    notifyListeners();
  }
}
