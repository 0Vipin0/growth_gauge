import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Represents a stable, validated unique identifier in the domain.
class UniqueId extends Equatable {
  static const Uuid _uuid = Uuid();

  final String value;

  const UniqueId._(this.value);

  /// Generates a new random UUIDv4 identifier.
  factory UniqueId.generate() {
    return UniqueId._(_uuid.v4());
  }

  /// Wraps an existing string identifier, ensuring it is non-empty.
  factory UniqueId.from(String id) {
    final trimmed = id.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(
          id, 'id', 'UniqueId cannot be empty or whitespace');
    }
    return UniqueId._(trimmed);
  }

  /// Checks if the identifier matches a standard 36-character UUIDv4 format.
  bool get isUuidV4 {
    final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[4][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
    );
    return uuidRegex.hasMatch(value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
