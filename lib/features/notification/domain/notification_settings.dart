import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';
part 'notification_settings.g.dart';

@freezed
abstract class NotificationSettings with _$NotificationSettings {
  const factory({
    @Default(true) bool notificationsEnabled,
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool dailyReminderEnabled,
    @Default(null) @TimeOfDayConverter() TimeOfDay? notificationTime,
  }) = _NotificationSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

class const TimeOfDayConverter() implements JsonConverter<TimeOfDay?, String?> {
  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) return null;
    final parts = json.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String? toJson(TimeOfDay? object) {
    if (object == null) return null;
    return '${object.hour}:${object.minute}';
  }
}
