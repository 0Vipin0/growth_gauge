import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_model.dart';
import 'counter_repository.dart';

class SharedPreferencesCounterRepository implements CounterRepository {
  static const String _storageKey = 'counters';

  @override
  Future<List<CounterModel>> loadCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final countersJson = prefs.getString(_storageKey);
    if (countersJson == null) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(countersJson);
    return decodedJson.map((json) => CounterModel.fromJson(json)).toList();
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    final prefs = await SharedPreferences.getInstance();
    final countersJson = jsonEncode(counters.map((c) => c.toJson()).toList());
    await prefs.setString(_storageKey, countersJson);
  }
}
