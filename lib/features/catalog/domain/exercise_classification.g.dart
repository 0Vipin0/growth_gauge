// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseClassification _$ExerciseClassificationFromJson(
        Map<String, dynamic> json) =>
    _ExerciseClassification(
      bodyRegions: (json['bodyRegions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$BodyRegionEnumMap, e))
              .toList() ??
          const [],
      primaryMuscles: (json['primaryMuscles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MuscleGroupEnumMap, e))
              .toList() ??
          const [],
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MuscleGroupEnumMap, e))
              .toList() ??
          const [],
      movementPatterns: (json['movementPatterns'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MovementPatternEnumMap, e))
              .toList() ??
          const [],
      laterality: json['laterality'] as String? ?? 'BILATERAL',
    );

Map<String, dynamic> _$ExerciseClassificationToJson(
        _ExerciseClassification instance) =>
    <String, dynamic>{
      'bodyRegions':
          instance.bodyRegions.map((e) => _$BodyRegionEnumMap[e]!).toList(),
      'primaryMuscles':
          instance.primaryMuscles.map((e) => _$MuscleGroupEnumMap[e]!).toList(),
      'secondaryMuscles': instance.secondaryMuscles
          .map((e) => _$MuscleGroupEnumMap[e]!)
          .toList(),
      'movementPatterns': instance.movementPatterns
          .map((e) => _$MovementPatternEnumMap[e]!)
          .toList(),
      'laterality': instance.laterality,
    };

const _$BodyRegionEnumMap = {
  BodyRegion.upperBody: 'UPPER_BODY',
  BodyRegion.lowerBody: 'LOWER_BODY',
  BodyRegion.fullBody: 'FULL_BODY',
  BodyRegion.core: 'CORE',
};

const _$MuscleGroupEnumMap = {
  MuscleGroup.chest: 'CHEST',
  MuscleGroup.lats: 'LATS',
  MuscleGroup.traps: 'TRAPS',
  MuscleGroup.frontDelts: 'FRONT_DELTS',
  MuscleGroup.sideDelts: 'SIDE_DELTS',
  MuscleGroup.rearDelts: 'REAR_DELTS',
  MuscleGroup.triceps: 'TRICEPS',
  MuscleGroup.biceps: 'BICEPS',
  MuscleGroup.forearms: 'FOREARMS',
  MuscleGroup.quads: 'QUADS',
  MuscleGroup.hamstrings: 'HAMSTRINGS',
  MuscleGroup.glutes: 'GLUTES',
  MuscleGroup.calves: 'CALVES',
  MuscleGroup.abs: 'ABS',
  MuscleGroup.obliques: 'OBLIQUES',
  MuscleGroup.lowerBack: 'LOWER_BACK',
};

const _$MovementPatternEnumMap = {
  MovementPattern.horizontalPush: 'HORIZONTAL_PUSH',
  MovementPattern.verticalPush: 'VERTICAL_PUSH',
  MovementPattern.horizontalPull: 'HORIZONTAL_PULL',
  MovementPattern.verticalPull: 'VERTICAL_PULL',
  MovementPattern.squat: 'SQUAT',
  MovementPattern.hinge: 'HINGE',
  MovementPattern.lunge: 'LUNGE',
  MovementPattern.carry: 'CARRY',
  MovementPattern.rotation: 'ROTATION',
  MovementPattern.isolation: 'ISOLATION',
};
