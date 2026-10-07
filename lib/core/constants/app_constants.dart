/// Global application constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'SubTrack';
  static const String appVersion = '1.0.0';

  // Network timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Storage keys
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserPreferences = 'user_preferences';
  static const String keySelectedCurrency = 'selected_currency';
  static const String keyThemeMode = 'theme_mode';
  static const String keySubscriptionsCache = 'cached_subscriptions';

  // Default Values
  static const String defaultCurrency = 'USD';
  static const String defaultLocale = 'en';
}
