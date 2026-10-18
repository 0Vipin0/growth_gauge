import '../../../core/concurrency/isolate_runner.dart';
import '../../../core/database/app_database.dart';
import '../../session/domain/session_enums.dart';
import '../../session/infrastructure/session_repository.dart';
import 'analytics_projector.dart';

/// Wipes all analytics read-model tables and replays every completed session
/// document in chronological order (Step 4.4).
///
/// Use when analytics data is stale, corrupted, or a schema change requires
/// a full re-projection from the authoritative session documents.
class ProjectionRebuilder({
  required final AppDatabase _db,
  required final IWorkoutSessionRepository _sessionRepo,
  required final AnalyticsProjector _projector,
  final IsolateRunner isolateRunner = const IsolateRunner(),
}) {
  final IsolateRunner _isolateRunner = isolateRunner;

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

    final sessions = allResult.dataOrNull!;
    final sortInputs = sessions
        .map(
          (session) => (
            session.id,
            session.status.name,
            (session.completedAt ?? session.createdAt).toIso8601String(),
          ),
        )
        .toList(growable: false);
    final orderedIds = await _isolateRunner.run(
      _orderCompletedSessionIds,
      sortInputs,
    );
    final byId = {for (final session in sessions) session.id: session};

    for (final id in orderedIds) {
      final session = byId[id];
      if (session != null) await _projector.project(session);
    }

    return orderedIds.length;
  }
}

List<String> _orderCompletedSessionIds(List<(String, String, String)> inputs) {
  final completed =
      inputs.where((entry) => entry.$2 == SessionStatus.completed.name).toList()
        ..sort((a, b) => a.$3.compareTo(b.$3));
  return completed.map((entry) => entry.$1).toList();
}
