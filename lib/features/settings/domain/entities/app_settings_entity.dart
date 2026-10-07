import 'package:equatable/equatable.dart';

/// Pure domain entity representing user preferences and app settings.
class AppSettingsEntity extends Equatable {
  final String selectedCurrency;
  final bool isDarkMode;
  final bool reminderNotificationsEnabled;
  final int reminderDaysBefore; // default 2 days before renewal
  final String locale;

  const AppSettingsEntity({
    this.selectedCurrency = 'USD',
    this.isDarkMode = true,
    this.reminderNotificationsEnabled = true,
    this.reminderDaysBefore = 2,
    this.locale = 'en',
  });

  AppSettingsEntity copyWith({
    String? selectedCurrency,
    bool? isDarkMode,
    bool? reminderNotificationsEnabled,
    int? reminderDaysBefore,
    String? locale,
  }) {
    return AppSettingsEntity(
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      reminderNotificationsEnabled:
          reminderNotificationsEnabled ?? this.reminderNotificationsEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        selectedCurrency,
        isDarkMode,
        reminderNotificationsEnabled,
        reminderDaysBefore,
        locale,
      ];
}
