import 'package:drift/drift.dart';

/// The authoritative document storage table.
/// Stores hierarchical domain aggregate roots in JSON format keyed by collection and ID.
class Documents() extends Table {
  /// The collection or namespace (e.g. 'users', 'exercises', 'templates', 'sessions').
  TextColumn get collection => text()();

  /// The unique aggregate identifier (UUIDv4 or stable ID).
  TextColumn get id => text()();

  /// Complete JSON payload of the aggregate root.
  TextColumn get jsonData => text()();

  /// Schema version of the stored JSON document.
  IntColumn get schemaVersion => integer().withDefault(const Constant(1))();

  /// UTC creation timestamp.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC update timestamp.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {collection, id};
}
