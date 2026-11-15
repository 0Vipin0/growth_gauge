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
      type: json['type'] as String? ?? 'general',
      status: json['status'] as String? ?? 'scheduled',
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
      'type': instance.type,
      'status': instance.status,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
      'triggeredAt': instance.triggeredAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'payload': instance.payload,
    };
