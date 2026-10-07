import 'dart:convert';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({required String token, String? refreshToken});
  Future<String?> getToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorage;
  final LocalStorageService localStorage;

  static const String _userCacheKey = 'cached_current_user';

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.localStorage,
  });

  @override
  Future<void> saveTokens({required String token, String? refreshToken}) async {
    await secureStorage.write(AppConstants.keyAuthToken, token);
    if (refreshToken != null) {
      await secureStorage.write(AppConstants.keyRefreshToken, refreshToken);
    }
  }

  @override
  Future<String?> getToken() {
    return secureStorage.read(AppConstants.keyAuthToken);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await localStorage.setString(_userCacheKey, userJson);
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = localStorage.getString(_userCacheKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  }

  @override
  Future<void> clearAuthData() async {
    await secureStorage.delete(AppConstants.keyAuthToken);
    await secureStorage.delete(AppConstants.keyRefreshToken);
    await localStorage.remove(_userCacheKey);
  }
}
