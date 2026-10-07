/// Centralized API endpoint configurations.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.substrack.app/v1';

  // Auth endpoints
  static const String authGoogle = '/auth/google';
  static const String authApple = '/auth/apple';
  static const String authMe = '/auth/me';
  static const String authRefreshToken = '/auth/refresh';
  static const String authSignOut = '/auth/logout';

  // Subscriptions endpoints
  static const String subscriptions = '/subscriptions';
  static String subscriptionById(String id) => '/subscriptions/$id';
  static String cancelSubscription(String id) => '/subscriptions/$id/cancel';

  // Analytics & Insights
  static const String analyticsSummary = '/analytics/summary';
  static const String analyticsUpcoming = '/analytics/upcoming';

  // User Settings
  static const String settings = '/settings';
}
