// app_data_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../counter/counter.dart';
import '../../timer/timer.dart';

part 'app_data.freezed.dart';

part 'app_data.g.dart';

@freezed
class AppData with _$AppData {
  factory AppData({
    @Default(1) int version, // Version 1 for initial structure
    @Default([]) List<CounterModel> counters,
    @Default([]) List<TimerModel> timers,
  }) = _AppData;

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);
}
