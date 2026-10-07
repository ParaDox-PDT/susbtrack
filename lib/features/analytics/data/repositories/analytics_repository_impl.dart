import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/spending_summary_entity.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../datasources/analytics_remote_data_source.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnalyticsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<SpendingSummaryEntity, Failure>> getSpendingSummary() async {
    if (!await networkInfo.isConnected) {
      return const Result.failure(NetworkFailure());
    }
    try {
      final summary = await remoteDataSource.fetchSpendingSummary();
      return Result.success(summary);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
