import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_model.freezed.dart';
part 'timer_model.g.dart';

@freezed
class TimerModel with _$TimerModel {
  factory TimerModel({
    required String id,
    required String name,
    required Duration interval,
    required String description,
    @Default([]) List<TimerLog> logs,
    Duration? target,
    List<String>? tags, // New property for tags
  }) = _TimerModel;

  factory TimerModel.fromJson(Map<String, dynamic> json) =>
      _$TimerModelFromJson(json);
}

@freezed
class TimerLog with _$TimerLog {
  factory TimerLog({
    required String id,
    required String action,
    required DateTime timestamp,
    required Duration interval,
  }) = _TimerLog;

  factory TimerLog.fromJson(Map<String, dynamic> json) =>
      _$TimerLogFromJson(json);
}
