import 'failures.dart';

/// A functional Result monad representing either a [Success] or an [Error].
sealed class const Result<T, E extends Failure>() {
  /// Creates a successful result holding [data].
  const factory success(T data) = Success<T, E>;

  /// Creates an error result holding [failure].
  const factory error(E failure) = Error<T, E>;

  /// Returns true if this is a [Success].
  bool get isSuccess => this is Success<T, E>;

  /// Returns true if this is an [Error].
  bool get isError => this is Error<T, E>;

  /// Returns the data if successful, or null if error.
  T? get dataOrNull => switch (this) {
    Success(data: final d) => d,
    Error() => null,
  };

  /// Returns the failure if error, or null if success.
  E? get errorOrNull => switch (this) {
    Success() => null,
    Error(failure: final f) => f,
  };

  /// Pattern-matches over the result.
  R when<R>({
    required R Function(T data) success,
    required R Function(E failure) error,
  }) {
    return switch (this) {
      Success(data: final d) => success(d),
      Error(failure: final f) => error(f),
    };
  }

  /// Maps the success value using [transform].
  Result<R, E> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final d) => Result.success(transform(d)),
      Error(failure: final f) => Result.error(f),
    };
  }

  /// Flat-maps the success value into another [Result].
  Result<R, E> flatMap<R>(Result<R, E> Function(T data) transform) {
    return switch (this) {
      Success(data: final d) => transform(d),
      Error(failure: final f) => Result.error(f),
    };
  }
}

/// Represents the successful outcome of an operation.
final class const Success<T, E extends Failure>(final T data)
    extends Result<T, E> {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T, E> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Result.success($data)';
}

/// Represents the failed outcome of an operation.
final class const Error<T, E extends Failure>(final E failure)
    extends Result<T, E> {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T, E> &&
          runtimeType == other.runtimeType &&
          failure == other.failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Result.error($failure)';
}
