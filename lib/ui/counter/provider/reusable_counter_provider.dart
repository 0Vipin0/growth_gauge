import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:uuid/uuid.dart';

class ReusableCounterProvider with ChangeNotifier {
  CounterModel counter;
  final Uuid _uuid = const Uuid();

  ReusableCounterProvider({required this.counter});

  int get count => counter.count;

  List<CounterLog> get logs => counter.logs;

  void _addLog(String action) {
    final newLog = CounterLog(
      id: _uuid.v4(),
      action: action,
      timestamp: DateTime.now(),
    );
    counter = counter.copyWith(logs: [...counter.logs, newLog]);
    notifyListeners();
  }

  void increaseCounter() {
    counter = counter.copyWith(count: counter.count + 1);
    _addLog('Increased');
  }

  void decreaseCounter() {
    counter = counter.copyWith(count: counter.count - 1);
    _addLog('Decreased');
  }
}
