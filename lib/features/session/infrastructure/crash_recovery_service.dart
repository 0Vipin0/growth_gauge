import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/workout_session.dart';
import 'session_repository.dart';

/// Cold-start query for persisted sessions that can be resumed or reviewed.
class CrashRecoveryService {
  const CrashRecoveryService(this._sessions);

  final IWorkoutSessionRepository _sessions;

  Future<Result<List<WorkoutSession>, Failure>> findRecoverable(
          String userId) =>
      _sessions.listUnfinished(userId);
}
