import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../notification/notification_service.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class CounterListProvider with ChangeNotifier {
  final CounterRepository repository;
  final NotificationService notificationService;
  List<CounterModel> _counters = [];

  CounterListProvider(
      {required this.repository, required this.notificationService}) {
    _loadCounters();
  }

  List<CounterModel> get counters => _counters;

  Future<void> _loadCounters() async {
    _counters = await repository.loadCounters();
    notifyListeners();
  }

  Future<void> saveCounters() async {
    await repository.saveCounters(_counters);
  }

  Future<void> clearCounters() async {
    _counters = [];
    saveCounters();
    notifyListeners();
  }

  void addCounter(CounterModel newCounter) {
    _counters.add(newCounter);
    saveCounters();
    notifyListeners();
  }

  CounterModel getCounter(CounterModel newCounter) {
    return _counters.firstWhere((counter) => counter.id == newCounter.id);
  }

  void updateCounter(CounterModel newCounter) {
    final CounterModel counter = getCounter(
      newCounter,
    ).copyWith(count: newCounter.count, logs: newCounter.logs);
    for (int i = 0; i < _counters.length; i++) {
      if (counter.id == _counters[i].id) {
        _counters[i] = counter;
      }
    }

    if (newCounter.target != counter.target) {
      final log = CounterLog(
        id: DateTime.now().toIso8601String(),
        action: 'Target updated to ${newCounter.target}',
        timestamp: DateTime.now(),
      );
      counter.logs.add(log);
    }

    // Check if the target is reached
    if (counter.target != null && counter.count >= counter.target!) {
      // Trigger notification
      _triggerNotification(
        title: 'Target Reached!',
        body:
            'Counter "${counter.name}" has reached its target of ${counter.target}.',
      );
    }

    saveCounters();
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

  void removeCounter(CounterModel counter) {
    _counters.remove(counter);
    saveCounters();
    notifyListeners();
  }

  void importCountersFromData(List<CounterModel> importedCounters) {
    _counters = importedCounters;
    saveCounters();
    notifyListeners();
  }

  Map<DateTime, int> extractCountsByDay(CounterModel counter) {
    final Map<DateTime, int> countsByDay = {};

    final List<CounterLog> countLog = getCounter(counter).logs;
    for (int j = 0; j < countLog.length; j++) {
      final dateTime = countLog[j].timestamp;
      final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
      countsByDay.update(
        dateOnly,
        (existingCount) => existingCount + 1,
        ifAbsent: () => 1,
      );
    }

    return countsByDay;
  }

  String convertToCSV() {
    final List<FlatCounterModel> flattenedDataList = [];
    for (final CounterModel counter in _counters) {
      for (final CounterLog log in counter.logs) {
        flattenedDataList.add(FlatCounterModel.fromCounterModel(counter, log));
      }
    }
    return convertFlattenedListToCsv(flattenedDataList);
  }

  String convertFlattenedListToCsv(List<FlatCounterModel> flattenedDataList) {
    final List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Name',
      'Count',
      'Description',
      'Target',
      'Log ID',
      'Log Action',
      'Log Timestamp',
    ]);

    for (final FlatCounterModel flattenedData in flattenedDataList) {
      rows.add(flattenedData.toCsvRow());
    }

    return const ListToCsvConverter().convert(rows);
  }
}
