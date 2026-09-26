// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CounterModel _$CounterModelFromJson(Map<String, dynamic> json) =>
    _CounterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
      description: json['description'] as String,
      logs: (json['logs'] as List<dynamic>)
          .map((e) => CounterLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      target: (json['target'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CounterModelToJson(_CounterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'description': instance.description,
      'logs': instance.logs,
      'target': instance.target,
      'tags': instance.tags,
    };

_CounterLog _$CounterLogFromJson(Map<String, dynamic> json) => _CounterLog(
      id: json['id'] as String,
      action: json['action'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CounterLogToJson(_CounterLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'timestamp': instance.timestamp.toIso8601String(),
    };
