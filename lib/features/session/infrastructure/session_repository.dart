import '../../../core/database/app_database.dart';
import '../../../core/database/document_store.dart';
import '../../../core/database/drift_document_store.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/session_enums.dart';
import '../domain/workout_session.dart';
import 'session_document_adapter.dart';

abstract interface class IWorkoutSessionRepository() {
  Future<Result<void, Failure>> save(WorkoutSession session);
  Future<Result<WorkoutSession, Failure>> getById(String id);
  Future<Result<List<WorkoutSession>, Failure>> listUnfinished(String userId);
}

class WorkoutSessionRepository implements IWorkoutSessionRepository {
  new(AppDatabase database)
    : _store = DriftDocumentStore<WorkoutSession>(
        database: database,
        adapter: const SessionDocumentAdapter(),
      );
  new withStore(this._store);

  final IDocumentStore<WorkoutSession> _store;

  @override
  Future<Result<void, Failure>> save(WorkoutSession session) =>
      _store.upsert(session);
  @override
  Future<Result<WorkoutSession, Failure>> getById(String id) =>
      _store.getById(id);
  @override
  Future<Result<List<WorkoutSession>, Failure>> listUnfinished(
    String userId,
  ) async {
    final result = await _store.getAll();
    return result.map(
      (sessions) => sessions
          .where(
            (session) =>
                session.userId == userId &&
                session.status != SessionStatus.draft &&
                session.status != SessionStatus.completed &&
                session.status != SessionStatus.cancelled &&
                session.status != SessionStatus.abandoned,
          )
          .toList(),
    );
  }
}
