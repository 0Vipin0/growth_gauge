// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetSet _$TargetSetFromJson(Map<String, dynamic> json) => _TargetSet(
      id: json['id'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      setType: $enumDecodeNullable(_$SetTypeEnumMap, json['setType']) ??
          SetType.working,
      targetWeight: (json['targetWeight'] as num?)?.toDouble(),
      targetReps: (json['targetReps'] as num?)?.toInt(),
      targetDurationSeconds: (json['targetDurationSeconds'] as num?)?.toInt(),
      targetDistanceMeters: (json['targetDistanceMeters'] as num?)?.toDouble(),
      targetRpe: (json['targetRpe'] as num?)?.toDouble(),
      targetRir: (json['targetRir'] as num?)?.toInt(),
      percentageOf1Rm: (json['percentageOf1Rm'] as num?)?.toDouble(),
      restPolicy: json['restPolicy'] == null
          ? null
          : RestPolicy.fromJson(json['restPolicy'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TargetSetToJson(_TargetSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setNumber': instance.setNumber,
      'setType': _$SetTypeEnumMap[instance.setType]!,
      'targetWeight': instance.targetWeight,
      'targetReps': instance.targetReps,
      'targetDurationSeconds': instance.targetDurationSeconds,
      'targetDistanceMeters': instance.targetDistanceMeters,
      'targetRpe': instance.targetRpe,
      'targetRir': instance.targetRir,
      'percentageOf1Rm': instance.percentageOf1Rm,
      'restPolicy': instance.restPolicy,
      'notes': instance.notes,
    };

const _$SetTypeEnumMap = {
  SetType.warmup: 'WARMUP',
  SetType.working: 'WORKING',
  SetType.backoff: 'BACKOFF',
  SetType.dropSet: 'DROP_SET',
  SetType.amrap: 'AMRAP',
  SetType.failure: 'FAILURE',
  SetType.cooldown: 'COOLDOWN',
  SetType.other: 'OTHER',
};
