import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_enums.dart';

part 'exercise_relationship.freezed.dart';
part 'exercise_relationship.g.dart';

@freezed
abstract class ExerciseRelationship with _$ExerciseRelationship {
  const factory ExerciseRelationship({
    required String sourceExerciseId,
    required String targetExerciseId,
    required RelationshipType type,
    String? reason,
  }) = _ExerciseRelationship;

  factory ExerciseRelationship.fromJson(Map<String, dynamic> json) =>
      _$ExerciseRelationshipFromJson(json);
}
