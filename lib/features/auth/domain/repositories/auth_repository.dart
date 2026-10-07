import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/user_entity.dart';

/// Contract defining authentication operations in the domain layer.
abstract class AuthRepository {
  Future<Result<UserEntity, Failure>> signInWithGoogle();
  Future<Result<UserEntity, Failure>> signInWithApple();
  Future<Result<UserEntity?, Failure>> getCurrentUser();
  Future<Result<void, Failure>> signOut();
  Stream<UserEntity?> authStateChanges();
}
