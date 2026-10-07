import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_settings_entity.dart';

abstract class SettingsRepository {
  Future<Result<AppSettingsEntity, Failure>> getSettings();
  Future<Result<void, Failure>> updateSettings(AppSettingsEntity settings);
}
