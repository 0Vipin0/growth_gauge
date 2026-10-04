import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_model.freezed.dart';
part 'timer_model.g.dart';

@freezed
abstract class TimerModel with _$TimerModel {
  factory({
    required String id,
    required String name,
    required Duration interval,
    required String description,
    @Default([]) List<TimerLog> logs,
    Duration? target,
    List<String>? tags, // New property for tags
  }) = _TimerModel;

  factory fromJson(Map<String, dynamic> json) => _$TimerModelFromJson(json);
}

@freezed
abstract class TimerLog with _$TimerLog {
  factory({
    required String id,
    required String action,
    required DateTime timestamp,
    required Duration interval,
  }) = _TimerLog;

  factory fromJson(Map<String, dynamic> json) => _$TimerLogFromJson(json);
}
