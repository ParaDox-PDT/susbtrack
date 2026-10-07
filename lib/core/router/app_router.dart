import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

/// Central GoRouter configuration for SubTrack.
/// Routes are mapped architecturally and can be replaced with real screen widgets
/// once the presentation UI layer is implemented.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.initial,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.initial,
        name: RouteNames.initialName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Initial / Splash'),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboardingName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Onboarding'),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Login'),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Home / Dashboard'),
      ),
      GoRoute(
        path: RouteNames.subscriptions,
        name: RouteNames.subscriptionsName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Subscriptions List'),
        routes: [
          GoRoute(
            path: 'add',
            name: RouteNames.addSubscriptionName,
            builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Add Subscription'),
          ),
          GoRoute(
            path: ':id',
            name: RouteNames.subscriptionDetailName,
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return _ArchitecturePlaceholderScreen(title: 'Subscription Detail ($id)');
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.analytics,
        name: RouteNames.analyticsName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Analytics & Insights'),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settingsName,
        builder: (context, state) => const _ArchitecturePlaceholderScreen(title: 'Settings'),
      ),
    ],
    errorBuilder: (context, state) => _ArchitecturePlaceholderScreen(
      title: 'Page Not Found: ${state.uri}',
    ),
  );
}

/// Minimal architectural placeholder widget ensuring router integrity
/// without defining actual UI screens until requested.
class _ArchitecturePlaceholderScreen extends StatelessWidget {
  final String title;
  const _ArchitecturePlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
