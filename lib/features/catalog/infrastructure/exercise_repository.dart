import '../../../core/database/app_database.dart';
import '../../../core/database/document_store.dart';
import '../../../core/database/drift_document_store.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/exercise.dart';
import 'exercise_document_adapter.dart';

/// Abstract contract for exercise persistence operations.
abstract class IExerciseRepository {
  Future<Result<void, Failure>> save(Exercise exercise);
  Future<Result<Exercise, Failure>> findById(String id);
  Future<Result<List<Exercise>, Failure>> findAll();
  Future<Result<List<Exercise>, Failure>> findByStatus(String status);
  Future<Result<void, Failure>> delete(String id);
  Stream<List<Exercise>> watchAll();
  Future<Result<int, Failure>> count();
}

/// Drift-backed implementation of [IExerciseRepository].
///
/// Exercises are stored as JSON documents in the shared [DriftDocumentStore]
/// under the `'exercises'` collection.
class ExerciseRepository implements IExerciseRepository {
  final IDocumentStore<Exercise> _store;

  ExerciseRepository(AppDatabase db)
      : _store = DriftDocumentStore<Exercise>(
          database: db,
          adapter: const ExerciseDocumentAdapter(),
        );

  /// Internal constructor used in tests with a pre-built store.
  ExerciseRepository.withStore(this._store);

  @override
  Future<Result<void, Failure>> save(Exercise exercise) =>
      _store.upsert(exercise);

  @override
  Future<Result<Exercise, Failure>> findById(String id) => _store.getById(id);

  @override
  Future<Result<List<Exercise>, Failure>> findAll() => _store.getAll();

  @override
  Future<Result<List<Exercise>, Failure>> findByStatus(String status) async {
    final result = await _store.getAll();
    return result.map(
      (exercises) => exercises
          .where((e) => e.status.name.toUpperCase() == status.toUpperCase())
          .toList(),
    );
  }

  @override
  Future<Result<void, Failure>> delete(String id) => _store.delete(id);

  @override
  Stream<List<Exercise>> watchAll() => _store.watchAll();

  @override
  Future<Result<int, Failure>> count() async {
    final result = await _store.getAll();
    return result.map((list) => list.length);
  }
}
