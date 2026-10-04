import '../domain/daily_workout_summary.dart';
import '../domain/exercise_set_metric.dart';
import '../domain/muscle_volume_stat.dart';
import '../domain/personal_record.dart';
import '../infrastructure/analytics_dao.dart';
import '../projection/projection_rebuilder.dart';

/// Application queries for visualization and statistics read models.
class AnalyticsQueries {
  final AnalyticsDao _dao;
  final ProjectionRebuilder _rebuilder;

  AnalyticsQueries({required this._dao, required this._rebuilder});

  Stream<List<DailyWorkoutSummary>> watchWorkoutHistory(String userId) =>
      _dao.watchWorkoutHistory(userId);

  Future<List<DailyWorkoutSummary>> getWorkoutHistoryInRange(
    String userId,
    DateTime from,
    DateTime to,
  ) => _dao.getWorkoutHistoryInRange(userId, from, to);

  Stream<List<ExerciseSetMetric>> watchExerciseProgression(
    String userId,
    String exerciseId,
  ) => _dao.watchExerciseProgression(userId, exerciseId);

  Future<List<ExerciseSetMetric>> getRecentSets(
    String userId,
    String exerciseId, {
    int limit = 20,
  }) => _dao.getRecentSets(userId, exerciseId, limit: limit);

  Stream<List<PersonalRecord>> watchPersonalRecords(
    String userId,
    String exerciseId,
  ) => _dao.watchPersonalRecords(userId, exerciseId);

  Stream<List<PersonalRecord>> watchAllPersonalRecords(String userId) =>
      _dao.watchAllPersonalRecords(userId);

  Stream<List<MuscleVolumeStat>> watchWeeklyMuscleVolume(
    String userId, {
    int weeks = 8,
  }) => _dao.watchWeeklyMuscleVolume(userId, weeks: weeks);

  Future<int> rebuildAnalytics() => _rebuilder.rebuildAll();
}
