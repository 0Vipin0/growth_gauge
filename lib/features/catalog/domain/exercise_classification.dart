import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_enums.dart';

part 'exercise_classification.freezed.dart';
part 'exercise_classification.g.dart';

@freezed
abstract class ExerciseClassification with _$ExerciseClassification {
  const factory({
    @Default([]) List<BodyRegion> bodyRegions,
    @Default([]) List<MuscleGroup> primaryMuscles,
    @Default([]) List<MuscleGroup> secondaryMuscles,
    @Default([]) List<MovementPattern> movementPatterns,
    @Default('BILATERAL') String laterality, // BILATERAL or UNILATERAL
  }) = _ExerciseClassification;

  factory fromJson(Map<String, dynamic> json) =>
      _$ExerciseClassificationFromJson(json);
}
