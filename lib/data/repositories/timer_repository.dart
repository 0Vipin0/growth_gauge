import 'package:growth_gauge/data/models/models.dart';

abstract class TimerRepository {
  Future<List<TimerModel>> getTimers();
  Future<void> saveTimers(List<TimerModel> timers);
  Future<void> clearTimers();
}
