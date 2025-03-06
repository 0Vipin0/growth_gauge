import 'dart:convert';

import 'package:flutter/material.dart';
import 'counter_model.dart';
import 'counter_repository.dart';

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

  void addCounter(CounterModel newCounter) {
    _counters.add(newCounter);
    saveCounters();
    notifyListeners();
  }

  CounterModel getCounter(CounterModel newCounter) {
    return _counters.firstWhere((counter) => counter.id == newCounter.id);
  }

  void updateCounter(CounterModel newCounter) {
    CounterModel counter = getCounter(newCounter)
        .copyWith(count: newCounter.count, logs: newCounter.logs);
    for (int i = 0; i < _counters.length; i++) {
      if (counter.id == _counters[i].id) {
        _counters[i] = counter;
      }
    }
    notifyListeners();
  }

  void removeCounter(CounterModel counter) {
    _counters.remove(counter);
    saveCounters();
    notifyListeners();
  }

  Future<String> exportCounters() async {
    final countersJson = jsonEncode(_counters.map((c) => c.toJson()).toList());
    return countersJson;
  }

  Future<void> importCounters(String jsonString) async {
    final List<dynamic> decodedJson = jsonDecode(jsonString);
    _counters = decodedJson.map((json) => CounterModel.fromJson(json)).toList();
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
}
