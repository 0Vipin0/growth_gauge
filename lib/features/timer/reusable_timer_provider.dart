import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import 'timer_model.dart';

class ReusableTimerProvider with ChangeNotifier {
  TimerModel timer;
  Timer? _ticker;
  Duration _currentInterval = Duration.zero;
  final Uuid _uuid = const Uuid();

  ReusableTimerProvider({required this.timer}) {
    _currentInterval = timer.interval;
  }

  Duration get currentInterval => _currentInterval;

  bool get isRunning => _ticker != null;

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentInterval += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void startOrPauseTimer() {
    if (_ticker == null) {
      _startTicker();
      timer = timer.copyWith(
        logs: [
          ...timer.logs,
          TimerLog(
            id: _uuid.v4(),
            action: 'Started',
            timestamp: DateTime.now(),
            interval: _currentInterval,
          )
        ],
      );
    } else {
      _ticker?.cancel();
      _ticker = null;
      timer = timer.copyWith(
        interval: _currentInterval,
        logs: [
          ...timer.logs,
          TimerLog(
            id: _uuid.v4(),
            action: 'Paused',
            timestamp: DateTime.now(),
            interval: _currentInterval,
          )
        ],
      );
    }
    notifyListeners();
  }

  void resetTimer() {
    _ticker?.cancel();
    _ticker = null;
    _currentInterval = Duration.zero;
    timer = timer.copyWith(
      interval: _currentInterval,
      logs: [
        ...timer.logs,
        TimerLog(
          id: _uuid.v4(),
          action: 'Reset',
          timestamp: DateTime.now(),
          interval: _currentInterval,
        )
      ],
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
