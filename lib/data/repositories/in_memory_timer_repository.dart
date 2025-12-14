import 'package:growth_gauge/data/models/models.dart';
import 'timer_repository.dart';

class InMemoryTimerRepository implements TimerRepository {
  List<TimerModel> _timers = [];

  @override
  Future<List<TimerModel>> getTimers() async {
    return _timers;
  }

  @override
  Future<void> saveTimers(List<TimerModel> timers) async {
    _timers = timers;
  }

  @override
  Future<void> clearTimers() async {
    _timers.clear();
  }
}
