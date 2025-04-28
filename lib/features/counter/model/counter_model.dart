import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_model.freezed.dart';
part 'counter_model.g.dart';

@freezed
class CounterModel with _$CounterModel {
  factory CounterModel({
    required String id,
    required String name,
    required int count,
    required String description,
    required List<CounterLog> logs,
    int? target, // New property for target
  }) = _CounterModel;

  factory CounterModel.fromJson(Map<String, dynamic> json) =>
      _$CounterModelFromJson(json);
}

@freezed
class CounterLog with _$CounterLog {
  factory CounterLog({
    required String id,
    required String action,
    required DateTime timestamp,
  }) = _CounterLog;

  factory CounterLog.fromJson(Map<String, dynamic> json) =>
      _$CounterLogFromJson(json);
}
