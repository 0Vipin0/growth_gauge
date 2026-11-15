// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettings _$NotificationSettingsFromJson(
  Map<String, dynamic> json,
) => _NotificationSettings(
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  soundEnabled: json['soundEnabled'] as bool? ?? true,
  vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
  dailyReminderEnabled: json['dailyReminderEnabled'] as bool? ?? true,
  notificationTime: json['notificationTime'] == null
      ? null
      : const TimeOfDayConverter().fromJson(
          json['notificationTime'] as String?,
        ),
);

Map<String, dynamic> _$NotificationSettingsToJson(
  _NotificationSettings instance,
) => <String, dynamic>{
  'notificationsEnabled': instance.notificationsEnabled,
  'soundEnabled': instance.soundEnabled,
  'vibrationEnabled': instance.vibrationEnabled,
  'dailyReminderEnabled': instance.dailyReminderEnabled,
  'notificationTime': const TimeOfDayConverter().toJson(
    instance.notificationTime,
  ),
};
