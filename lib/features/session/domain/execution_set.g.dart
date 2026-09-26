// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExecutionSet _$ExecutionSetFromJson(Map<String, dynamic> json) =>
    _ExecutionSet(
      id: json['id'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      setType: $enumDecodeNullable(_$SetTypeEnumMap, json['setType']) ??
          SetType.working,
      targetWeight: (json['targetWeight'] as num?)?.toDouble(),
      targetReps: (json['targetReps'] as num?)?.toInt(),
      targetDurationSeconds: (json['targetDurationSeconds'] as num?)?.toInt(),
      targetDistanceMeters: (json['targetDistanceMeters'] as num?)?.toDouble(),
      targetCalories: (json['targetCalories'] as num?)?.toInt(),
      targetRpe: (json['targetRpe'] as num?)?.toDouble(),
      targetRir: (json['targetRir'] as num?)?.toInt(),
      percentageOf1Rm: (json['percentageOf1Rm'] as num?)?.toDouble(),
      actualWeight: (json['actualWeight'] as num?)?.toDouble(),
      actualReps: (json['actualReps'] as num?)?.toInt(),
      actualDurationSeconds: (json['actualDurationSeconds'] as num?)?.toInt(),
      actualDistanceMeters: (json['actualDistanceMeters'] as num?)?.toDouble(),
      actualCalories: (json['actualCalories'] as num?)?.toInt(),
      rpe: (json['rpe'] as num?)?.toDouble(),
      rir: (json['rir'] as num?)?.toInt(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      status:
          $enumDecodeNullable(_$ExecutionSetStatusEnumMap, json['status']) ??
              ExecutionSetStatus.planned,
      plannedRestSeconds: (json['plannedRestSeconds'] as num?)?.toInt() ?? 0,
      restAutoStart: json['restAutoStart'] as bool? ?? false,
      restAllowSkip: json['restAllowSkip'] as bool? ?? true,
      restAllowExtend: json['restAllowExtend'] as bool? ?? true,
      restMinimumSeconds: (json['restMinimumSeconds'] as num?)?.toInt(),
      restMaximumSeconds: (json['restMaximumSeconds'] as num?)?.toInt(),
      actualRestSeconds: (json['actualRestSeconds'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ExecutionSetToJson(_ExecutionSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setNumber': instance.setNumber,
      'setType': _$SetTypeEnumMap[instance.setType]!,
      'targetWeight': instance.targetWeight,
      'targetReps': instance.targetReps,
      'targetDurationSeconds': instance.targetDurationSeconds,
      'targetDistanceMeters': instance.targetDistanceMeters,
      'targetCalories': instance.targetCalories,
      'targetRpe': instance.targetRpe,
      'targetRir': instance.targetRir,
      'percentageOf1Rm': instance.percentageOf1Rm,
      'actualWeight': instance.actualWeight,
      'actualReps': instance.actualReps,
      'actualDurationSeconds': instance.actualDurationSeconds,
      'actualDistanceMeters': instance.actualDistanceMeters,
      'actualCalories': instance.actualCalories,
      'rpe': instance.rpe,
      'rir': instance.rir,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'status': _$ExecutionSetStatusEnumMap[instance.status]!,
      'plannedRestSeconds': instance.plannedRestSeconds,
      'restAutoStart': instance.restAutoStart,
      'restAllowSkip': instance.restAllowSkip,
      'restAllowExtend': instance.restAllowExtend,
      'restMinimumSeconds': instance.restMinimumSeconds,
      'restMaximumSeconds': instance.restMaximumSeconds,
      'actualRestSeconds': instance.actualRestSeconds,
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

const _$ExecutionSetStatusEnumMap = {
  ExecutionSetStatus.planned: 'planned',
  ExecutionSetStatus.inProgress: 'inProgress',
  ExecutionSetStatus.completed: 'completed',
  ExecutionSetStatus.skipped: 'skipped',
};
