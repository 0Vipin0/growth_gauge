import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
import '../repository/repository.dart';

class CounterListProvider with ChangeNotifier {
  final CounterRepository repository;
  List<CounterModel> _counters = [];

  CounterListProvider({required this.repository}) {
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
    saveCounters();
    notifyListeners();
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
