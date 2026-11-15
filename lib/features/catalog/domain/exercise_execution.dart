import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_execution.freezed.dart';
part 'exercise_execution.g.dart';

@freezed
abstract class ExerciseExecutionProfile with _$ExerciseExecutionProfile {
  const factory({
    @Default([]) List<String> setupInstructions,
    @Default([]) List<String> executionInstructions,
    String? breathingInstructions,
    @Default([]) List<String> techniqueCues,
    String? tempo,
    String? rangeOfMotion,
  }) = _ExerciseExecutionProfile;

  factory fromJson(Map<String, dynamic> json) =>
      _$ExerciseExecutionProfileFromJson(json);
}
