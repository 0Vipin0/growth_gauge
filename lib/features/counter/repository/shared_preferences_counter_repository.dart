import 'dart:convert';

import 'package:growth_gauge/features/settings/config/config.dart';
import '../model/model.dart';
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
