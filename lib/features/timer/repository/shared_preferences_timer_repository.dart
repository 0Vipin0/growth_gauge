import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import 'timer_repository.dart';

class SharedPreferencesTimerRepository implements TimerRepository {
  static const String _storageKey = 'timers';

  @override
  Future<List<TimerModel>> getTimers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? timersJson = prefs.getString(_storageKey);
    if (timersJson != null) {
      final List<dynamic> timersList = json.decode(timersJson);
      return timersList
          .map((timer) => TimerModel.fromJson(timer as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveTimers(List<TimerModel> timers) async {
    final prefs = await SharedPreferences.getInstance();
    final String timersJson =
        json.encode(timers.map((timer) => timer.toJson()).toList());
    await prefs.setString(_storageKey, timersJson);
  }

  @override
  Future<void> clearTimers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
