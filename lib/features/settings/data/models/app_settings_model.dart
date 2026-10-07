import '../../domain/entities/app_settings_entity.dart';

class AppSettingsModel extends AppSettingsEntity {
  const AppSettingsModel({
    super.selectedCurrency = 'USD',
    super.isDarkMode = true,
    super.reminderNotificationsEnabled = true,
    super.reminderDaysBefore = 2,
    super.locale = 'en',
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      selectedCurrency: json['selectedCurrency'] as String? ?? 'USD',
      isDarkMode: json['isDarkMode'] as bool? ?? true,
      reminderNotificationsEnabled: json['reminderNotificationsEnabled'] as bool? ?? true,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 2,
      locale: json['locale'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedCurrency': selectedCurrency,
      'isDarkMode': isDarkMode,
      'reminderNotificationsEnabled': reminderNotificationsEnabled,
      'reminderDaysBefore': reminderDaysBefore,
      'locale': locale,
    };
  }

  factory AppSettingsModel.fromEntity(AppSettingsEntity entity) {
    return AppSettingsModel(
      selectedCurrency: entity.selectedCurrency,
      isDarkMode: entity.isDarkMode,
      reminderNotificationsEnabled: entity.reminderNotificationsEnabled,
      reminderDaysBefore: entity.reminderDaysBefore,
      locale: entity.locale,
    );
  }
}
