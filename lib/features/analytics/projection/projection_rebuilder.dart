import '../../../core/database/app_database.dart';
import '../../session/domain/session_enums.dart';
import '../../session/infrastructure/session_repository.dart';
import 'analytics_projector.dart';

/// Wipes all analytics read-model tables and replays every completed session
/// document in chronological order (Step 4.4).
///
/// Use when analytics data is stale, corrupted, or a schema change requires
/// a full re-projection from the authoritative session documents.
class ProjectionRebuilder {
  final AppDatabase _db;
  final IWorkoutSessionRepository _sessionRepo;
  final AnalyticsProjector _projector;

  ProjectionRebuilder({
    required this._db,
    required this._sessionRepo,
    required this._projector,
  });

  /// Clears all five analytics tables and re-projects all completed sessions.
  ///
  /// Returns the number of sessions projected.
  Future<int> rebuildAll() async {
    // 1. Wipe all analytics read models.
    await _db.transaction(() async {
      await _db.delete(_db.dailyWorkoutSummaries).go();
      await _db.delete(_db.exerciseSetMetrics).go();
      await _db.delete(_db.personalRecords).go();
      await _db.delete(_db.muscleVolumeBreakdowns).go();
      await _db.delete(_db.restIntervalMetrics).go();
    });

    // 2. Fetch all session documents and replay completed ones chronologically.
    final allResult = await _sessionRepo.listAll();
    if (allResult.isError) return 0;

    final completed =
        allResult.dataOrNull!
            .where((s) => s.status == SessionStatus.completed)
            .toList()
          ..sort((a, b) {
            final aTime = a.completedAt ?? a.createdAt;
            final bTime = b.completedAt ?? b.createdAt;
            return aTime.compareTo(bTime);
          });

    for (final session in completed) {
      await _projector.project(session);
    }

    return completed.length;
  }
}
