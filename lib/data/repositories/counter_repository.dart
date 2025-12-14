import 'package:growth_gauge/data/models/models.dart';

abstract class CounterRepository {
  Future<List<CounterModel>> loadCounters();
  Future<void> saveCounters(List<CounterModel> counters);
}
