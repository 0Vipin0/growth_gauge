import '../error/failures.dart';
import '../error/result.dart';

/// Generic interface for an authoritative document store managing domain aggregate roots.
abstract class IDocumentStore<T> {
  /// Inserts or updates an entity in the document store.
  Future<Result<void, Failure>> upsert(T entity);

  /// Retrieves an entity by its unique ID.
  Future<Result<T, Failure>> getById(String id);

  /// Retrieves all entities in the collection.
  Future<Result<List<T>, Failure>> getAll();

  /// Deletes an entity by its unique ID.
  Future<Result<void, Failure>> delete(String id);

  /// Emits reactive updates whenever documents in this collection change.
  Stream<List<T>> watchAll();

  /// Deletes all documents within this collection.
  Future<Result<void, Failure>> clearCollection();
}
