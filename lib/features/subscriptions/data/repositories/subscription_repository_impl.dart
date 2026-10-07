import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_local_data_source.dart';
import '../datasources/subscription_remote_data_source.dart';
import '../models/subscription_model.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;
  final SubscriptionLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SubscriptionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<List<SubscriptionEntity>, Failure>> getSubscriptions() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteSubscriptions = await remoteDataSource.fetchSubscriptions();
        await localDataSource.cacheSubscriptions(remoteSubscriptions);
        return Result.success(remoteSubscriptions);
      } else {
        final cached = await localDataSource.getCachedSubscriptions();
        return Result.success(cached);
      }
    } on ServerException catch (e) {
      final cached = await localDataSource.getCachedSubscriptions();
      if (cached.isNotEmpty) {
        return Result.success(cached);
      }
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<SubscriptionEntity, Failure>> getSubscriptionById(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final remote = await remoteDataSource.fetchSubscriptionById(id);
        return Result.success(remote);
      } else {
        final cachedList = await localDataSource.getCachedSubscriptions();
        final match = cachedList.where((s) => s.id == id).firstOrNull;
        if (match != null) {
          return Result.success(match);
        }
        return const Result.failure(NetworkFailure());
      }
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<SubscriptionEntity, Failure>> addSubscription(
    SubscriptionEntity subscription,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      final model = SubscriptionModel.fromEntity(subscription);
      final created = await remoteDataSource.createSubscription(model);
      return Result.success(created);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<SubscriptionEntity, Failure>> updateSubscription(
    SubscriptionEntity subscription,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      final model = SubscriptionModel.fromEntity(subscription);
      final updated = await remoteDataSource.updateSubscription(model);
      return Result.success(updated);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteSubscription(String id) async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      await remoteDataSource.deleteSubscription(id);
      return const Result.success(null);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> toggleSubscriptionStatus(String id, bool isActive) async {
    try {
      final subResult = await getSubscriptionById(id);
      return subResult.fold(
        onSuccess: (entity) async {
          final updated = entity.copyWith(isActive: isActive);
          final res = await updateSubscription(updated);
          return res.fold(
            onSuccess: (_) => const Result.success(null),
            onFailure: (failure) => Result.failure(failure),
          );
        },
        onFailure: (failure) => Result.failure(failure),
      );
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
