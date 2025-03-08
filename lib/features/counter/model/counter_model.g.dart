// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterModelImpl _$$CounterModelImplFromJson(Map<String, dynamic> json) =>
    _$CounterModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
      description: json['description'] as String,
      logs: (json['logs'] as List<dynamic>)
          .map((e) => CounterLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CounterModelImplToJson(_$CounterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'description': instance.description,
      'logs': instance.logs,
    };

_$CounterLogImpl _$$CounterLogImplFromJson(Map<String, dynamic> json) =>
    _$CounterLogImpl(
      id: json['id'] as String,
      action: json['action'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$CounterLogImplToJson(_$CounterLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'timestamp': instance.timestamp.toIso8601String(),
    };
