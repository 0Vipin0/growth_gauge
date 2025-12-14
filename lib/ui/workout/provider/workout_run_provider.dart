import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/ui/core/shared_preferences_config.dart';

import '../services/tts_service.dart';

class WorkoutRunProvider with ChangeNotifier {
  WorkoutTemplate? _template;
  int _currentIndex = 0;
  Timer? _timer;
  int? _remaining; // seconds
  bool _isPaused = false;

  // For set-style steps
  int _currentSetIndex = 0;

  final TtsService? ttsService;

  WorkoutRunProvider({this.ttsService}) {
    // If a global TTS service is registered in the app, prefer it
  }

  WorkoutTemplate? get template => _template;
  int get currentIndex => _currentIndex;
  int get currentSetIndex => _currentSetIndex;
  int? get remaining => _remaining;
  bool get isPaused => _isPaused;

  Map<String, dynamic>? get currentStep => _template == null || _template!.steps.isEmpty ? null : _template!.steps[_currentIndex];

  void startSession(WorkoutTemplate t, {TtsService? tts}) {
    _template = t;
    _currentIndex = 0;
    _currentSetIndex = 0;
    _isPaused = false;
    _remaining = _initialRemainingForStep(currentStep);

    // Speak start via TTS
    // Speak start via TTS only if enabled in settings
    final enabled = _isTtsEnabled();
    if (enabled) {
      (tts ?? ttsService)?.speak('Starting ${currentStep?['name'] ?? t.name}');
    }

    notifyListeners();
    _startTimerIfNeeded();
  }

  void pause() {
    if (_timer != null && !_isPaused) {
      _timer?.cancel();
      _isPaused = true;
      notifyListeners();
    }
  }

  void resume() {
    if (_isPaused) {
      _isPaused = false;
      notifyListeners();
      _startTimerIfNeeded();
    }
  }

  void next() {
    if (_template == null) return;

    final step = currentStep;
    // If current step is a multi-set, advance sets first
    if (step != null && step.containsKey('sets')) {
      final totalSets = step['sets'] as int;
      if (_currentSetIndex < totalSets - 1) {
        _currentSetIndex++;
        // reset remaining for next set if duration present
        _remaining = _initialRemainingForStep(step);
        notifyListeners();
        _startTimerIfNeeded();
        return;
      }
    }

    if (_currentIndex < _template!.steps.length - 1) {
      _currentIndex++;
      _currentSetIndex = 0;
      _remaining = _initialRemainingForStep(currentStep);
      if (_isTtsEnabled()) ttsService?.speak('Starting ${currentStep?['name'] ?? ''}');
      notifyListeners();
      _startTimerIfNeeded();
    }
  }

  void prev() {
    if (_template == null) return;
    if (_currentIndex > 0) {
      _currentIndex--;
      _currentSetIndex = 0;
      _remaining = _initialRemainingForStep(currentStep);
      notifyListeners();
      _startTimerIfNeeded();
    }
  }

  void completeSet() {
    // Helper to mark current set done (same as next())
    next();
  }

  int? _initialRemainingForStep(Map<String, dynamic>? step) {
    if (step == null) return null;
    if (step.containsKey('duration')) return step['duration'] as int;
    // if it's a 'rest' entry represented as duration, also handled
    return null;
  }

  bool _isTtsEnabled() {
    try {
      // Prefer a global shared preferences setting
      return SharedPreferencesHelper.getTtsEnabled() ?? true;
    } catch (_) {
      return true;
    }
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();
    if (_remaining != null && !_isPaused) {
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (_remaining! > 0) {
          _remaining = _remaining! - 1;
          notifyListeners();
          // cue last 3 seconds
          if (_remaining! <= 3 && _remaining! > 0 && _isTtsEnabled()) {
            ttsService?.speak('$_remaining');
          }
        } else {
          t.cancel();
        }
      });
    }
  }

  void stop() {
    _timer?.cancel();
    _template = null;
    _currentIndex = 0;
    _currentSetIndex = 0;
    _remaining = null;
    _isPaused = false;
    notifyListeners();
  }
}
