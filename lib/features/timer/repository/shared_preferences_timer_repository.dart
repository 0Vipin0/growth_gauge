import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import 'timer_repository.dart';

class SharedPreferencesTimerRepository implements TimerRepository {
  final SharedPreferences _prefs;

  SharedPreferencesTimerRepository(this._prefs);

  @override
  Future<List<TimerModel>> getTimers() async {
    final String? timersJson = _prefs.getString('timers');
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
    final String timersJson =
        json.encode(timers.map((timer) => timer.toJson()).toList());
    await _prefs.setString('timers', timersJson);
  }

  @override
  Future<void> clearTimers() async {
    await _prefs.remove('timers');
  }
}
