import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/analytics_enums.dart';
import '../domain/daily_workout_summary.dart';
import '../domain/exercise_set_metric.dart';
import '../domain/muscle_volume_stat.dart';
import '../domain/personal_record.dart';

/// Drift DAO exposing reactive analytics query streams for the UI layer.
///
/// All queries are scoped to a [userId] and return typed domain read models.
/// Queries use Drift's reactive `watch()` streams so the UI auto-updates when
/// the projector writes new rows.
class const AnalyticsDao(final AppDatabase _db) {
  // ---------------------------------------------------------------------------
  // Workout History
  // ---------------------------------------------------------------------------

  /// Stream of all session summaries for [userId], newest first.
  Stream<List<DailyWorkoutSummary>> watchWorkoutHistory(String userId) {
    return (_db.select(_db.dailyWorkoutSummaries)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(_mapSummary).toList());
  }

  /// Returns session summaries within [from]..[to] for frequency heatmap.
  Future<List<DailyWorkoutSummary>> getWorkoutHistoryInRange(
    String userId,
    DateTime from,
    DateTime to,
  ) async {
    final rows =
        await (_db.select(_db.dailyWorkoutSummaries)
              ..where(
                (t) =>
                    t.userId.equals(userId) &
                    t.date.isBiggerOrEqualValue(from) &
                    t.date.isSmallerOrEqualValue(to),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.date)]))
            .get();
    return rows.map(_mapSummary).toList();
  }

  // ---------------------------------------------------------------------------
  // Exercise Progression
  // ---------------------------------------------------------------------------

  /// Stream of all set metrics for [exerciseId] and [userId], oldest first.
  /// Used to render the 1RM progression line chart.
  Stream<List<ExerciseSetMetric>> watchExerciseProgression(
    String userId,
    String exerciseId,
  ) {
    return (_db.select(_db.exerciseSetMetrics)
          ..where(
            (t) => t.userId.equals(userId) & t.exerciseId.equals(exerciseId),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch()
        .map((rows) => rows.map(_mapSetMetric).toList());
  }

  /// Last N set metrics for [exerciseId] for recent-history display.
  Future<List<ExerciseSetMetric>> getRecentSets(
    String userId,
    String exerciseId, {
    int limit = 20,
  }) async {
    final rows =
        await (_db.select(_db.exerciseSetMetrics)
              ..where(
                (t) =>
                    t.userId.equals(userId) & t.exerciseId.equals(exerciseId),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
              ..limit(limit))
            .get();
    return rows.map(_mapSetMetric).toList();
  }

  // ---------------------------------------------------------------------------
  // Personal Records
  // ---------------------------------------------------------------------------

  /// Stream of the current best PR for each type for [exerciseId].
  Stream<List<PersonalRecord>> watchPersonalRecords(
    String userId,
    String exerciseId,
  ) {
    return (_db.select(_db.personalRecords)
          ..where(
            (t) => t.userId.equals(userId) & t.exerciseId.equals(exerciseId),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)]))
        .watch()
        .map((rows) => rows.map(_mapPr).toList());
  }

  /// Stream of the most recent PR across ALL exercises for [userId].
  /// Used for the trophy overview screen.
  Stream<List<PersonalRecord>> watchAllPersonalRecords(String userId) {
    return (_db.select(_db.personalRecords)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)]))
        .watch()
        .map((rows) => rows.map(_mapPr).toList());
  }

  // ---------------------------------------------------------------------------
  // Muscle Volume
  // ---------------------------------------------------------------------------

  /// Weekly muscle volume stats for [userId] within the last [weeks] ISO weeks.
  Stream<List<MuscleVolumeStat>> watchWeeklyMuscleVolume(
    String userId, {
    int weeks = 8,
  }) {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: weeks * 7));
    return (_db.select(_db.muscleVolumeBreakdowns)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.weekStartDate.isBiggerOrEqualValue(cutoff),
          )
          ..orderBy([
            (t) => OrderingTerm.asc(t.isoYear),
            (t) => OrderingTerm.asc(t.isoWeek),
          ]))
        .watch()
        .map((rows) => rows.map(_mapMuscleVolume).toList());
  }

  // ---------------------------------------------------------------------------
  // Row mappers with safe fallbacks
  // ---------------------------------------------------------------------------

  DailyWorkoutSummary _mapSummary(DailyWorkoutSummaryRow row) =>
      DailyWorkoutSummary(
        id: row.id,
        date: row.date,
        sessionId: row.sessionId,
        userId: row.userId,
        templateName: row.templateName,
        durationSeconds: row.durationSeconds,
        activeSeconds: row.activeSeconds,
        volumeLoadKg: row.volumeLoadKg,
        totalCompletedSets: row.totalCompletedSets,
        totalCompletedReps: row.totalCompletedReps,
        averageRpe: row.averageRpe,
      );

  ExerciseSetMetric _mapSetMetric(ExerciseSetMetricRow row) =>
      ExerciseSetMetric(
        id: row.id,
        sessionId: row.sessionId,
        exerciseId: row.exerciseId,
        userId: row.userId,
        timestamp: row.timestamp,
        weightKg: row.weightKg,
        reps: row.reps,
        volumeLoad: row.volumeLoad,
        estimated1Rm: row.estimated1Rm,
        rpe: row.rpe,
        rir: row.rir,
        setType: row.setType,
      );

  PersonalRecord _mapPr(PersonalRecordRow row) {
    // Safely parse PR type with a fallback to avoid crash on unexpected database string values
    final parsedPrType = PrType.values.firstWhere(
      (e) => e.name.toLowerCase() == row.prType.toLowerCase(),
      orElse: () => PrType.maxWeight,
    );

    return PersonalRecord(
      id: row.id,
      exerciseId: row.exerciseId,
      userId: row.userId,
      prType: parsedPrType,
      value: row.value,
      sessionId: row.sessionId,
      setId: row.setId,
      achievedAt: row.achievedAt,
      replacesRecordId: row.replacesRecordId,
    );
  }

  MuscleVolumeStat _mapMuscleVolume(MuscleVolumeBreakdownRow row) =>
      MuscleVolumeStat(
        muscleGroup: row.muscleGroup,
        isoYear: row.isoYear,
        isoWeek: row.isoWeek,
        weekStartDate: row.weekStartDate,
        totalVolumeKg: row.totalVolumeKg,
        totalSets: row.totalSets,
      );
}
