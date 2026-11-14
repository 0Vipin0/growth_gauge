import 'package:equatable/equatable.dart';

/// Base class for all domain and infrastructure failures.
abstract class const Failure(final String message, [final Object? cause])
    extends Equatable {
  @override
  List<Object?> get props => [message, cause];

  @override
  String toString() =>
      '$runtimeType: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Represents a failure occurring in SQLite or document store persistence.
class const DatabaseFailure(super.message, [super.cause]) extends Failure;

/// Represents an entity that was requested but could not be located.
class const NotFoundFailure(super.message, final String entityId, [super.cause])
    extends Failure {
  @override
  List<Object?> get props => [message, entityId, cause];
}

/// Represents a business rule or invariant validation error.
class const ValidationFailure(
  super.message, [
  final String? invalidField,
  super.cause,
]) extends Failure {
  @override
  List<Object?> get props => [message, invalidField, cause];
}

/// Represents a state or ID conflict error.
class const ConflictFailure(
  super.message,
  final String conflictId, [
  super.cause,
]) extends Failure {
  @override
  List<Object?> get props => [message, conflictId, cause];
}
