import 'package:flutter/foundation.dart';

import '../../../data/repositories/activity_repository.dart';
import 'package:growth_gauge/data/models/models.dart';

class InsightsProvider with ChangeNotifier {
  final ActivityRepository repository;

  InsightsProvider({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DailyAggregate> _daily = [];
  List<DailyAggregate> get daily => List.unmodifiable(_daily);

  Future<void> fetchDailyAggregates(String activityId, DateTime from, DateTime to) async {
    _isLoading = true;
    notifyListeners();

    final rows = await repository.dailyAggregates(activityId, from, to);
    _daily = rows.map((m) => DailyAggregate.fromMap(m)).toList();

    _isLoading = false;
    notifyListeners();
  }
}
