import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_enums.dart';

part 'measurement_profile.freezed.dart';
part 'measurement_profile.g.dart';

@freezed
abstract class ExerciseMeasurementProfile with _$ExerciseMeasurementProfile {
  const factory({
    @Default(MetricType.weightAndReps) MetricType defaultMetricType,
    @Default([MetricType.weightAndReps]) List<MetricType> supportedMetricTypes,
    @Default(true) bool supportsWeight,
    @Default(true) bool supportsReps,
    @Default(false) bool supportsDuration,
    @Default(false) bool supportsDistance,
    @Default(false) bool supportsCalories,
    @Default(true) bool supportsRpe,
    @Default(true) bool supportsRir,
    @Default(false) bool supportsTempo,
  }) = _ExerciseMeasurementProfile;

  factory fromJson(Map<String, dynamic> json) =>
      _$ExerciseMeasurementProfileFromJson(json);
}
