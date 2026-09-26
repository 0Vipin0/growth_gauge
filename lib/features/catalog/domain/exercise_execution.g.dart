// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseExecutionProfile _$ExerciseExecutionProfileFromJson(
        Map<String, dynamic> json) =>
    _ExerciseExecutionProfile(
      setupInstructions: (json['setupInstructions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      executionInstructions: (json['executionInstructions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      breathingInstructions: json['breathingInstructions'] as String?,
      techniqueCues: (json['techniqueCues'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tempo: json['tempo'] as String?,
      rangeOfMotion: json['rangeOfMotion'] as String?,
    );

Map<String, dynamic> _$ExerciseExecutionProfileToJson(
        _ExerciseExecutionProfile instance) =>
    <String, dynamic>{
      'setupInstructions': instance.setupInstructions,
      'executionInstructions': instance.executionInstructions,
      'breathingInstructions': instance.breathingInstructions,
      'techniqueCues': instance.techniqueCues,
      'tempo': instance.tempo,
      'rangeOfMotion': instance.rangeOfMotion,
    };
