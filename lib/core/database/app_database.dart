import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/documents_table.dart';

part 'app_database.g.dart';

/// The primary application database managing authoritative document storage
/// and materialized relational analytics read models.
@DriftDatabase(tables: [Documents])
class AppDatabase([QueryExecutor? e]) extends _$AppDatabase {
  this : super(e ?? _openConnection());

  /// Creates an isolated in-memory SQLite database instance for testing.
  factory inMemory() {
    return AppDatabase(NativeDatabase.memory());
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'growth_gauge_core_db');
  }
}
