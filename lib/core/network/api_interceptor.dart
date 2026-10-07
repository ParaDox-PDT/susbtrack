import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage_service.dart';

/// Centralized Dio interceptor for attaching auth headers, handling token expiration,
/// and standardizing network error reporting.
class ApiInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  ApiInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(AppConstants.keyAuthToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // You can handle 401 Unauthorized refresh tokens or logout triggers here
    return handler.next(err);
  }
}
