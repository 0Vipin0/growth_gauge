import 'package:freezed_annotation/freezed_annotation.dart';

import 'rest_policy.dart';
import 'template_enums.dart';

part 'target_set.freezed.dart';
part 'target_set.g.dart';

@freezed
abstract class TargetSet with _$TargetSet {
  const factory TargetSet({
    required String id,
    required int setNumber,
    @Default(SetType.working) SetType setType,
    double? targetWeight, // Canonical kg
    int? targetReps,
    int? targetDurationSeconds,
    double? targetDistanceMeters,
    double? targetRpe,
    int? targetRir,
    double? percentageOf1Rm,
    RestPolicy? restPolicy,
    String? notes,
  }) = _TargetSet;

  factory TargetSet.fromJson(Map<String, dynamic> json) => _$TargetSetFromJson(json);
}
