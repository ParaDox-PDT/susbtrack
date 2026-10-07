/// A functional Result type to model operations that can either succeed or fail.
/// This prevents throwing unhandled exceptions across architecture layers.
sealed class Result<T, E> {
  const Result();

  /// Creates a successful [Result] containing [data].
  const factory Result.success(T data) = Success<T, E>;

  /// Creates a failed [Result] containing [error].
  const factory Result.failure(E error) = Error<T, E>;

  /// Returns true if this is a [Success].
  bool get isSuccess => this is Success<T, E>;

  /// Returns true if this is an [Error].
  bool get isFailure => this is Error<T, E>;

  /// Returns the data if this is [Success], or null otherwise.
  T? get dataOrNull => switch (this) {
        Success(data: final d) => d,
        Error() => null,
      };

  /// Returns the error if this is [Error], or null otherwise.
  E? get errorOrNull => switch (this) {
        Success() => null,
        Error(error: final e) => e,
      };

  /// Folds the result into a single value based on success or error.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(E error) onFailure,
  }) {
    return switch (this) {
      Success(data: final d) => onSuccess(d),
      Error(error: final e) => onFailure(e),
    };
  }

  /// Maps the success value to another type.
  Result<R, E> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final d) => Result.success(transform(d)),
      Error(error: final e) => Result.failure(e),
    };
  }
}

/// Represents a successful result containing [data].
final class Success<T, E> extends Result<T, E> {
  final T data;
  const Success(this.data);

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

/// Represents a failed result containing [error].
final class Error<T, E> extends Result<T, E> {
  final E error;
  const Error(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T, E> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Result.failure($error)';
}
