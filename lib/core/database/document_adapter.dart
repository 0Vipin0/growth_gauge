/// Contract for adapting an aggregate entity to and from JSON for document storage.
abstract class DocumentAdapter<T>() {
  /// The collection or namespace name (e.g. 'users', 'exercises').
  String get collection;

  /// Extracts the unique ID of the entity.
  String getId(T entity);

  /// The current schema version of this entity.
  int get schemaVersion => 1;

  /// Serializes the entity into a JSON map.
  Map<String, dynamic> toJson(T entity);

  /// Deserializes the entity from a JSON map.
  T fromJson(Map<String, dynamic> json);

  /// Optional hook to extract creation timestamp, defaults to nowUtc if null.
  DateTime? getCreatedAt(T entity) => null;

  /// Optional hook to extract update timestamp, defaults to nowUtc if null.
  DateTime? getUpdatedAt(T entity) => null;
}
