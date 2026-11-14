import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set_metric.freezed.dart';

/// Immutable read model for a single completed set's analytics data.
@freezed
abstract class ExerciseSetMetric with _$ExerciseSetMetric {
  const factory({
    required String id,
    required String sessionId,
    required String exerciseId,
    required String userId,
    required DateTime timestamp,
    double? weightKg,
    int? reps,
    double? volumeLoad,
    double? estimated1Rm,
    double? rpe,
    int? rir,
    required String setType,
  }) = _ExerciseSetMetric;
}
