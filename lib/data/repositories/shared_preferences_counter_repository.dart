import 'dart:convert';

import '../../ui/core/shared_preferences_config.dart';
import '../models/models.dart';

import 'counter_repository.dart';

class SharedPreferencesCounterRepository implements CounterRepository {
  @override
  Future<List<CounterModel>> loadCounters() async {
    final String? countersJson = SharedPreferencesHelper.getCounters();
    if (countersJson == null) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(countersJson) as List<dynamic>;
    return decodedJson
        .map((json) => CounterModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    final countersJson = jsonEncode(counters.map((c) => c.toJson()).toList());
    await SharedPreferencesHelper.setCounters(countersJson);
  }
}
