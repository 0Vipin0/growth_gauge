// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingGoal _$TrainingGoalFromJson(Map<String, dynamic> json) =>
    _TrainingGoal(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$GoalTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      startValue: (json['startValue'] as num).toDouble(),
      targetValue: (json['targetValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      unit: json['unit'] as String? ?? 'kg',
      startDate: DateTime.parse(json['startDate'] as String),
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      status:
          $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
          GoalStatus.active,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$TrainingGoalToJson(_TrainingGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$GoalTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'startValue': instance.startValue,
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'unit': instance.unit,
      'startDate': instance.startDate.toIso8601String(),
      'targetDate': instance.targetDate?.toIso8601String(),
      'status': _$GoalStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$GoalTypeEnumMap = {
  GoalType.strength: 'STRENGTH',
  GoalType.endurance: 'ENDURANCE',
  GoalType.workoutFrequency: 'WORKOUT_FREQUENCY',
  GoalType.volume: 'VOLUME',
  GoalType.repetition: 'REPETITION',
  GoalType.duration: 'DURATION',
  GoalType.distance: 'DISTANCE',
  GoalType.bodyWeight: 'BODY_WEIGHT',
  GoalType.custom: 'CUSTOM',
};

const _$GoalStatusEnumMap = {
  GoalStatus.active: 'ACTIVE',
  GoalStatus.achieved: 'ACHIEVED',
  GoalStatus.abandoned: 'ABANDONED',
};
