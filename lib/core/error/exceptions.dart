/// Base exception class for data-layer exceptions.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => '$runtimeType: $message (code: $statusCode)';
}

/// Thrown when remote API returns an error or status code >= 400.
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
  });
}

/// Thrown when local cache or storage operation fails.
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.statusCode,
  });
}

/// Thrown when network connection is unreachable or timed out.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network error occurred',
    super.statusCode,
  });
}

/// Thrown when authentication fails (token expired, invalid credentials, etc.).
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.statusCode,
  });
}

/// Thrown when data validation fails.
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.statusCode,
  });
}
