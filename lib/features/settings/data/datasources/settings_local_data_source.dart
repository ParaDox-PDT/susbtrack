import 'dart:convert';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../models/app_settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getSettings();
  Future<void> saveSettings(AppSettingsModel settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final LocalStorageService _localStorage;

  SettingsLocalDataSourceImpl(this._localStorage);

  @override
  Future<AppSettingsModel> getSettings() async {
    final cached = _localStorage.getString(AppConstants.keyUserPreferences);
    if (cached != null) {
      return AppSettingsModel.fromJson(jsonDecode(cached) as Map<String, dynamic>);
    }
    return const AppSettingsModel();
  }

  @override
  Future<void> saveSettings(AppSettingsModel settings) async {
    await _localStorage.setString(
      AppConstants.keyUserPreferences,
      jsonEncode(settings.toJson()),
    );
  }
}
