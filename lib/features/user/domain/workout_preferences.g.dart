// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPreferences _$WorkoutPreferencesFromJson(Map<String, dynamic> json) =>
    _WorkoutPreferences(
      userId: json['userId'] as String,
      defaultRestSeconds: (json['defaultRestSeconds'] as num?)?.toInt() ?? 90,
      defaultWarmupEnabled: json['defaultWarmupEnabled'] as bool? ?? true,
      defaultCooldownEnabled: json['defaultCooldownEnabled'] as bool? ?? false,
      autoStartRestTimer: json['autoStartRestTimer'] as bool? ?? true,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      keepScreenAwake: json['keepScreenAwake'] as bool? ?? true,
      showRpe: json['showRpe'] as bool? ?? true,
      showRir: json['showRir'] as bool? ?? false,
      defaultSessionDurationMinutes:
          (json['defaultSessionDurationMinutes'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$WorkoutPreferencesToJson(_WorkoutPreferences instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'defaultRestSeconds': instance.defaultRestSeconds,
      'defaultWarmupEnabled': instance.defaultWarmupEnabled,
      'defaultCooldownEnabled': instance.defaultCooldownEnabled,
      'autoStartRestTimer': instance.autoStartRestTimer,
      'soundEnabled': instance.soundEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'keepScreenAwake': instance.keepScreenAwake,
      'showRpe': instance.showRpe,
      'showRir': instance.showRir,
      'defaultSessionDurationMinutes': instance.defaultSessionDurationMinutes,
    };
