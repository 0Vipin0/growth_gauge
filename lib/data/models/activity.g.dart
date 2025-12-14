// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountBasedActivityImpl _$$CountBasedActivityImplFromJson(
        Map<String, dynamic> json) =>
    _$CountBasedActivityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      unit: json['unit'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      goalId: json['goalId'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      count: (json['count'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CountBasedActivityImplToJson(
        _$CountBasedActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'unit': instance.unit,
      'isFavorite': instance.isFavorite,
      'goalId': instance.goalId,
      'tags': instance.tags,
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$TimeBasedActivityImpl _$$TimeBasedActivityImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeBasedActivityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      unit: json['unit'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      goalId: json['goalId'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TimeBasedActivityImplToJson(
        _$TimeBasedActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'unit': instance.unit,
      'isFavorite': instance.isFavorite,
      'goalId': instance.goalId,
      'tags': instance.tags,
      'duration': instance.duration.inMicroseconds,
      'runtimeType': instance.$type,
    };

_$ActivityLogImpl _$$ActivityLogImplFromJson(Map<String, dynamic> json) =>
    _$ActivityLogImpl(
      id: json['id'] as String,
      activityId: json['activityId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      value: (json['value'] as num).toDouble(),
      notes: json['notes'] as String?,
      rpe: (json['rpe'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ActivityLogImplToJson(_$ActivityLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityId': instance.activityId,
      'timestamp': instance.timestamp.toIso8601String(),
      'value': instance.value,
      'notes': instance.notes,
      'rpe': instance.rpe,
    };

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      targetValue: (json['targetValue'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
