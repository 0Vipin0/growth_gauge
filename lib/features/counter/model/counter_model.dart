import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_model.freezed.dart';
part 'counter_model.g.dart';

@freezed
abstract class CounterModel with _$CounterModel {
  factory({
    required String id,
    required String name,
    required int count,
    required String description,
    required List<CounterLog> logs,
    int? target,
    List<String>? tags, // New property for tags
  }) = _CounterModel;

  factory fromJson(Map<String, dynamic> json) => _$CounterModelFromJson(json);
}

@freezed
abstract class CounterLog with _$CounterLog {
  factory({
    required String id,
    required String action,
    required DateTime timestamp,
  }) = _CounterLog;

  factory fromJson(Map<String, dynamic> json) => _$CounterLogFromJson(json);
}
