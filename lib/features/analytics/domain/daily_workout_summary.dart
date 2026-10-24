import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_workout_summary.freezed.dart';

/// Immutable read model returned from [AnalyticsDao] for dashboard display.
@freezed
abstract class DailyWorkoutSummary with _$DailyWorkoutSummary {
  const factory({
    required String id,
    required DateTime date,
    required String sessionId,
    required String userId,
    required String templateName,
    required int durationSeconds,
    required int activeSeconds,
    required double volumeLoadKg,
    required int totalCompletedSets,
    required int totalCompletedReps,
    double? averageRpe,
  }) = _DailyWorkoutSummary;
}
