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
}
