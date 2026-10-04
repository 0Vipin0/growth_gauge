import 'package:equatable/equatable.dart';

/// Base class for all domain and infrastructure failures.
abstract class Failure extends Equatable {
  final String message;
  final Object? cause;

  const Failure(this.message, [this.cause]);

  @override
  List<Object?> get props => [message, cause];

  @override
  String toString() =>
      '$runtimeType: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Represents a failure occurring in SQLite or document store persistence.
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.cause]);
}

/// Represents an entity that was requested but could not be located.
class NotFoundFailure extends Failure {
  final String entityId;

  const NotFoundFailure(super.message, this.entityId, [super.cause]);

  @override
  List<Object?> get props => [message, entityId, cause];
}

/// Represents a business rule or invariant validation error.
class ValidationFailure extends Failure {
  final String? invalidField;

  const ValidationFailure(super.message, [this.invalidField, super.cause]);

  @override
  List<Object?> get props => [message, invalidField, cause];
}

/// Represents a state or ID conflict error.
class ConflictFailure extends Failure {
  final String conflictId;

  const ConflictFailure(super.message, this.conflictId, [super.cause]);

  @override
  List<Object?> get props => [message, conflictId, cause];
}
