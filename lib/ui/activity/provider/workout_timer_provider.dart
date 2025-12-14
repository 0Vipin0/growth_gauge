import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:growth_gauge/data/models/models.dart';

enum TimerState { idle, running, paused, completed }

class WorkoutTimerProvider with ChangeNotifier {
  Activity? activeTemplate;
  int currentStepIndex = 0;
  Duration currentTimerValue = Duration.zero;
  TimerState timerState = TimerState.idle;
  final Queue<String> ttsQueue = Queue<String>();

  void start() {
    timerState = TimerState.running;
    notifyListeners();
  }

  void pause() {
    timerState = TimerState.paused;
    notifyListeners();
  }

  void stop() {
    timerState = TimerState.completed;
    currentStepIndex = 0;
    currentTimerValue = Duration.zero;
    notifyListeners();
  }

  void enqueueTts(String text) {
    ttsQueue.add(text);
    notifyListeners();
  }
}
