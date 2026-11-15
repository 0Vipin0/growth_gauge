import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_preferences.freezed.dart';
part 'workout_preferences.g.dart';

/// User workout execution configuration, timer defaults, and UI preferences.
@freezed
abstract class WorkoutPreferences with _$WorkoutPreferences {
  const factory({
    required String userId,
    @Default(90) int defaultRestSeconds,
    @Default(true) bool defaultWarmupEnabled,
    @Default(false) bool defaultCooldownEnabled,
    @Default(true) bool autoStartRestTimer,
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool keepScreenAwake,
    @Default(true) bool showRpe,
    @Default(false) bool showRir,
    @Default(60) int defaultSessionDurationMinutes,
  }) = _WorkoutPreferences;

  factory fromJson(Map<String, dynamic> json) =>
      _$WorkoutPreferencesFromJson(json);
}
