import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_execution.freezed.dart';
part 'exercise_execution.g.dart';

@freezed
abstract class ExerciseExecutionProfile with _$ExerciseExecutionProfile {
  const factory ExerciseExecutionProfile({
    @Default([]) List<String> setupInstructions,
    @Default([]) List<String> executionInstructions,
    String? breathingInstructions,
    @Default([]) List<String> techniqueCues,
    String? tempo,
    String? rangeOfMotion,
  }) = _ExerciseExecutionProfile;

  factory ExerciseExecutionProfile.fromJson(Map<String, dynamic> json) =>
      _$ExerciseExecutionProfileFromJson(json);
}
