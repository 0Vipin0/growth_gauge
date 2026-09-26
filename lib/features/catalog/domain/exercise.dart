import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_classification.dart';
import 'exercise_enums.dart';
import 'exercise_equipment.dart';
import 'exercise_execution.dart';
import 'exercise_relationship.dart';
import 'measurement_profile.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

/// The authoritative aggregate root for an exercise catalog item.
@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    @Default([]) List<String> aliases,
    @Default('') String description,
    @Default(ExerciseStatus.active) ExerciseStatus status,
    @Default(ExerciseSourceType.system) ExerciseSourceType sourceType,
    String? createdById,
    String? forkedFromExerciseId,
    @Default(1) int version,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(ExerciseClassification()) ExerciseClassification classification,
    @Default(ExerciseExecutionProfile()) ExerciseExecutionProfile execution,
    @Default(ExerciseEquipmentProfile()) ExerciseEquipmentProfile equipment,
    @Default([]) List<ExerciseRelationship> relationships,
    @Default(ExerciseMeasurementProfile()) ExerciseMeasurementProfile measurementProfile,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}
