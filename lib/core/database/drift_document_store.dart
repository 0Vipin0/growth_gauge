import 'dart:convert';

import 'package:drift/drift.dart';

import '../error/failures.dart';
import '../error/result.dart';
import '../time/app_clock.dart';
import 'app_database.dart';
import 'document_adapter.dart';
import 'document_store.dart';

/// Drift-backed implementation of [IDocumentStore].
class DriftDocumentStore<T> implements IDocumentStore<T> {
  final AppDatabase _db;
  final DocumentAdapter<T> _adapter;

  DriftDocumentStore({
    required AppDatabase database,
    required DocumentAdapter<T> adapter,
  })  : _db = database,
        _adapter = adapter;

  @override
  Future<Result<void, Failure>> upsert(T entity) async {
    try {
      final id = _adapter.getId(entity);
      final jsonMap = _adapter.toJson(entity);
      final jsonStr = jsonEncode(jsonMap);

      // Check existing document to preserve original createdAt if available
      final existing = await (_db.select(_db.documents)
            ..where((t) => t.collection.equals(_adapter.collection) & t.id.equals(id)))
          .getSingleOrNull();

      final now = AppClock.nowUtc();
      final createdAt = _adapter.getCreatedAt(entity) ?? existing?.createdAt ?? now;
      final updatedAt = _adapter.getUpdatedAt(entity) ?? now;

      final companion = DocumentsCompanion(
        collection: Value(_adapter.collection),
        id: Value(id),
        jsonData: Value(jsonStr),
        schemaVersion: Value(_adapter.schemaVersion),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      );

      await _db.into(_db.documents).insertOnConflictUpdate(companion);
      return const Result.success(null);
    } catch (e, stack) {
      return Result.error(DatabaseFailure('Failed to upsert document in ${_adapter.collection}', e));
    }
  }

  @override
  Future<Result<T, Failure>> getById(String id) async {
    try {
      final row = await (_db.select(_db.documents)
            ..where((t) => t.collection.equals(_adapter.collection) & t.id.equals(id)))
          .getSingleOrNull();

      if (row == null) {
        return Result.error(NotFoundFailure('Document not found in ${_adapter.collection}', id));
      }

      final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
      final entity = _adapter.fromJson(jsonMap);
      return Result.success(entity);
    } catch (e, stack) {
      return Result.error(DatabaseFailure('Failed to get document $id in ${_adapter.collection}', e));
    }
  }

  @override
  Future<Result<List<T>, Failure>> getAll() async {
    try {
      final rows = await (_db.select(_db.documents)
            ..where((t) => t.collection.equals(_adapter.collection))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

      final list = rows.map((r) {
        final jsonMap = jsonDecode(r.jsonData) as Map<String, dynamic>;
        return _adapter.fromJson(jsonMap);
      }).toList();

      return Result.success(list);
    } catch (e, stack) {
      return Result.error(DatabaseFailure('Failed to list documents in ${_adapter.collection}', e));
    }
  }

  @override
  Future<Result<void, Failure>> delete(String id) async {
    try {
      await (_db.delete(_db.documents)
            ..where((t) => t.collection.equals(_adapter.collection) & t.id.equals(id)))
          .go();
      return const Result.success(null);
    } catch (e, stack) {
      return Result.error(DatabaseFailure('Failed to delete document $id in ${_adapter.collection}', e));
    }
  }

  @override
  Stream<List<T>> watchAll() {
    return (_db.select(_db.documents)
          ..where((t) => t.collection.equals(_adapter.collection))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch()
        .map((rows) {
      return rows.map((r) {
        final jsonMap = jsonDecode(r.jsonData) as Map<String, dynamic>;
        return _adapter.fromJson(jsonMap);
      }).toList();
    });
  }

  @override
  Future<Result<void, Failure>> clearCollection() async {
    try {
      await (_db.delete(_db.documents)
            ..where((t) => t.collection.equals(_adapter.collection)))
          .go();
      return const Result.success(null);
    } catch (e, stack) {
      return Result.error(DatabaseFailure('Failed to clear collection ${_adapter.collection}', e));
    }
  }
}
