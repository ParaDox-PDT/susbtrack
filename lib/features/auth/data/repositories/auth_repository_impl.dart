import 'dart:async';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  final _authStateController = StreamController<UserEntity?>.broadcast();

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Stream<UserEntity?> authStateChanges() => _authStateController.stream;

  @override
  Future<Result<UserEntity, Failure>> signInWithGoogle() async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      final user = await remoteDataSource.signInWithGoogle();
      await localDataSource.saveUser(user);
      _authStateController.add(user);
      return Result.success(user);
    } on AuthException catch (e) {
      return Result.failure(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<UserEntity, Failure>> signInWithApple() async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      final user = await remoteDataSource.signInWithApple();
      await localDataSource.saveUser(user);
      _authStateController.add(user);
      return Result.success(user);
    } on AuthException catch (e) {
      return Result.failure(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<UserEntity?, Failure>> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getUser();
      if (cachedUser != null) {
        _authStateController.add(cachedUser);
        return Result.success(cachedUser);
      }
      if (await networkInfo.isConnected) {
        final token = await localDataSource.getToken();
        if (token != null) {
          final remoteUser = await remoteDataSource.fetchMe();
          await localDataSource.saveUser(remoteUser);
          _authStateController.add(remoteUser);
          return Result.success(remoteUser);
        }
      }
      _authStateController.add(null);
      return const Result.success(null);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> signOut() async {
    try {
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.signOut();
        } catch (_) {
          // Proceed with local logout even if remote fails
        }
      }
      await localDataSource.clearAuthData();
      _authStateController.add(null);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
