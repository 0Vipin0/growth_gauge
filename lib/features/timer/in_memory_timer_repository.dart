import 'package:uuid/uuid.dart';

import 'timer_model.dart';
import 'timer_repository.dart';

class InMemoryTimerRepository implements TimerRepository {
  List<TimerModel> _timers = [
    TimerModel(
      id: const Uuid().v4(),
      interval: Duration.zero,
      name: 'New Timer',
      description: 'New Timer',
      logs: [],
    )
  ];

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
