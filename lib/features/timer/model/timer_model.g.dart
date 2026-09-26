// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimerModel _$TimerModelFromJson(Map<String, dynamic> json) => _TimerModel(
  id: json['id'] as String,
  name: json['name'] as String,
  interval: Duration(microseconds: (json['interval'] as num).toInt()),
  description: json['description'] as String,
  logs:
      (json['logs'] as List<dynamic>?)
          ?.map((e) => TimerLog.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  target: json['target'] == null
      ? null
      : Duration(microseconds: (json['target'] as num).toInt()),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$TimerModelToJson(_TimerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'interval': instance.interval.inMicroseconds,
      'description': instance.description,
      'logs': instance.logs,
      'target': instance.target?.inMicroseconds,
      'tags': instance.tags,
    };

_TimerLog _$TimerLogFromJson(Map<String, dynamic> json) => _TimerLog(
  id: json['id'] as String,
  action: json['action'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  interval: Duration(microseconds: (json['interval'] as num).toInt()),
);

Map<String, dynamic> _$TimerLogToJson(_TimerLog instance) => <String, dynamic>{
  'id': instance.id,
  'action': instance.action,
  'timestamp': instance.timestamp.toIso8601String(),
  'interval': instance.interval.inMicroseconds,
};
