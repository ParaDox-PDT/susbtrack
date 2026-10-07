import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<UserModel> fetchMe();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> signInWithGoogle() async {
    // When Firebase or REST is connected, calls API / Firebase SDK
    final response = await _apiClient.post(ApiEndpoints.authGoogle);
    return UserModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<UserModel> signInWithApple() async {
    final response = await _apiClient.post(ApiEndpoints.authApple);
    return UserModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<UserModel> fetchMe() async {
    final response = await _apiClient.get(ApiEndpoints.authMe);
    return UserModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<void> signOut() async {
    await _apiClient.post(ApiEndpoints.authSignOut);
  }
}
