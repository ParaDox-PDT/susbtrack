import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCase<AppSettingsEntity, NoParams> {
  final SettingsRepository _repository;

  GetSettingsUseCase(this._repository);

  @override
  Future<Result<AppSettingsEntity, Failure>> call(NoParams params) {
    return _repository.getSettings();
  }
}
