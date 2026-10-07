import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/app_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Result<AppSettingsEntity, Failure>> getSettings() async {
    try {
      final settings = await _localDataSource.getSettings();
      return Result.success(settings);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(message: e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateSettings(AppSettingsEntity settings) async {
    try {
      final model = AppSettingsModel.fromEntity(settings);
      await _localDataSource.saveSettings(model);
      return const Result.success(null);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(message: e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
