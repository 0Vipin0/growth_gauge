// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestInterval _$RestIntervalFromJson(Map<String, dynamic> json) =>
    _RestInterval(
      id: json['id'] as String,
      executionSetId: json['executionSetId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      plannedDurationSeconds: (json['plannedDurationSeconds'] as num).toInt(),
      actualDurationSeconds: (json['actualDurationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RestIntervalToJson(_RestInterval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'executionSetId': instance.executionSetId,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'plannedDurationSeconds': instance.plannedDurationSeconds,
      'actualDurationSeconds': instance.actualDurationSeconds,
    };
