// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationLog _$NotificationLogFromJson(Map<String, dynamic> json) =>
    _NotificationLog(
      id: (json['id'] as num).toInt(),
      notificationId: (json['notificationId'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      type:
          $enumDecodeNullable(_$NotificationCategoryEnumMap, json['type']) ??
          NotificationCategory.general,
      status:
          $enumDecodeNullable(_$NotificationStatusEnumMap, json['status']) ??
          NotificationStatus.scheduled,
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
      triggeredAt: json['triggeredAt'] == null
          ? null
          : DateTime.parse(json['triggeredAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      payload: json['payload'] as String?,
    );

Map<String, dynamic> _$NotificationLogToJson(_NotificationLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notificationId': instance.notificationId,
      'title': instance.title,
      'body': instance.body,
      'type': _$NotificationCategoryEnumMap[instance.type]!,
      'status': _$NotificationStatusEnumMap[instance.status]!,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
      'triggeredAt': instance.triggeredAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'payload': instance.payload,
    };

const _$NotificationCategoryEnumMap = {
  NotificationCategory.general: 'general',
  NotificationCategory.testInstant: 'testInstant',
  NotificationCategory.testDelayed: 'testDelayed',
  NotificationCategory.dailyReminder: 'dailyReminder',
  NotificationCategory.scheduledReminder: 'scheduledReminder',
};

const _$NotificationStatusEnumMap = {
  NotificationStatus.scheduled: 'scheduled',
  NotificationStatus.delivered: 'delivered',
  NotificationStatus.cancelled: 'cancelled',
};
