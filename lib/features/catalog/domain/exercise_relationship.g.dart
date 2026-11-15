// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseRelationship _$ExerciseRelationshipFromJson(
  Map<String, dynamic> json,
) => _ExerciseRelationship(
  sourceExerciseId: json['sourceExerciseId'] as String,
  targetExerciseId: json['targetExerciseId'] as String,
  type: $enumDecode(_$RelationshipTypeEnumMap, json['type']),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$ExerciseRelationshipToJson(
  _ExerciseRelationship instance,
) => <String, dynamic>{
  'sourceExerciseId': instance.sourceExerciseId,
  'targetExerciseId': instance.targetExerciseId,
  'type': _$RelationshipTypeEnumMap[instance.type]!,
  'reason': instance.reason,
};

const _$RelationshipTypeEnumMap = {
  RelationshipType.alternative: 'ALTERNATIVE',
  RelationshipType.regression: 'REGRESSION',
  RelationshipType.progression: 'PROGRESSION',
  RelationshipType.variationOf: 'VARIATION_OF',
  RelationshipType.warmupFor: 'WARMUP_FOR',
  RelationshipType.cooldownFor: 'COOLDOWN_FOR',
};
