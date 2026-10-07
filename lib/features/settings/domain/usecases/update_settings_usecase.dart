import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_settings_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsParams extends Equatable {
  final AppSettingsEntity settings;

  const UpdateSettingsParams(this.settings);

  @override
  List<Object?> get props => [settings];
}

class UpdateSettingsUseCase implements UseCase<void, UpdateSettingsParams> {
  final SettingsRepository _repository;

  UpdateSettingsUseCase(this._repository);

  @override
  Future<Result<void, Failure>> call(UpdateSettingsParams params) {
    return _repository.updateSettings(params.settings);
  }
}
