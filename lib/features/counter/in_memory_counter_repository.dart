import 'counter_model.dart';
import 'counter_repository.dart';

class InMemoryCounterRepository implements CounterRepository {
  List<CounterModel> _counters = [];

  @override
  Future<List<CounterModel>> loadCounters() async {
    return _counters;
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    _counters = counters;
  }
}
