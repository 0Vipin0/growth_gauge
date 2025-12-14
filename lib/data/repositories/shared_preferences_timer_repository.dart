import 'dart:convert';

import '../../ui/core/shared_preferences_config.dart';
import '../models/models.dart';
import 'timer_repository.dart';

class SharedPreferencesTimerRepository implements TimerRepository {
  @override
  Future<List<TimerModel>> getTimers() async {
    final String? timersJson = SharedPreferencesHelper.getTimers();
    if (timersJson != null) {
      final List<dynamic> timersList = json.decode(timersJson) as List<dynamic>;
      return timersList
          .map((timer) => TimerModel.fromJson(timer as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveTimers(List<TimerModel> timers) async {
    final String timersJson = json.encode(
      timers.map((timer) => timer.toJson()).toList(),
    );
    await SharedPreferencesHelper.setTimers(timersJson);
  }

  @override
  Future<void> clearTimers() async {
    await SharedPreferencesHelper.removeTimers();
  }
}
