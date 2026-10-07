import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/analytics/presentation/pages/analytics_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_flow_screen.dart';
import '../../features/onboarding/presentation/pages/splash_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/subscriptions/presentation/pages/add_subscription_screen.dart';
import '../../features/subscriptions/presentation/pages/connect_gmail_screen.dart';
import '../../features/subscriptions/presentation/pages/find_subscriptions_screen.dart';
import '../../features/subscriptions/presentation/pages/home_dashboard_screen.dart';
import '../../features/subscriptions/presentation/pages/subscription_detail_screen.dart';
import '../../features/subscriptions/presentation/pages/subscriptions_list_screen.dart';
import 'route_names.dart';

/// Central GoRouter configuration for SubTrack connecting all real screens.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static CustomTransitionPage<void> _fadePage({
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.initial,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: RouteNames.initial,
        name: RouteNames.initialName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboardingName,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const OnboardingFlowScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.discovery,
        name: RouteNames.discoveryName,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const FindSubscriptionsScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.connectGmail,
        name: RouteNames.connectGmailName,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const ConnectGmailScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.subscriptions,
        name: RouteNames.subscriptionsName,
        builder: (context, state) => const SubscriptionsListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            name: RouteNames.addSubscriptionName,
            builder: (context, state) => const AddSubscriptionScreen(),
          ),
          GoRoute(
            path: ':id',
            name: RouteNames.subscriptionDetailName,
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return SubscriptionDetailScreen(subscriptionId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.analytics,
        name: RouteNames.analyticsName,
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settingsName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
