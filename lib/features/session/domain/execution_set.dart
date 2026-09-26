import 'package:freezed_annotation/freezed_annotation.dart';

import '../../template/domain/template_enums.dart';
import 'session_enums.dart';

part 'execution_set.freezed.dart';
part 'execution_set.g.dart';

@freezed
abstract class ExecutionSet with _$ExecutionSet {
  const factory ExecutionSet({
    required String id,
    required int setNumber,
    @Default(SetType.working) SetType setType,
    double? targetWeight,
    int? targetReps,
    int? targetDurationSeconds,
    double? targetDistanceMeters,
    int? targetCalories,
    double? targetRpe,
    int? targetRir,
    double? percentageOf1Rm,
    double? actualWeight,
    int? actualReps,
    int? actualDurationSeconds,
    double? actualDistanceMeters,
    int? actualCalories,
    double? rpe,
    int? rir,
    DateTime? startedAt,
    DateTime? completedAt,
    @Default(ExecutionSetStatus.planned) ExecutionSetStatus status,
    @Default(0) int plannedRestSeconds,
    int? actualRestSeconds,
    String? notes,
  }) = _ExecutionSet;

  factory ExecutionSet.fromJson(Map<String, dynamic> json) =>
      _$ExecutionSetFromJson(json);
}
