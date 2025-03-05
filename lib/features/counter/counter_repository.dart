import 'counter_model.dart';

abstract class CounterRepository {
  Future<List<CounterModel>> loadCounters();
  Future<void> saveCounters(List<CounterModel> counters);
}
