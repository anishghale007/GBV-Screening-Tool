import 'package:flutter/material.dart';
import 'package:gbv/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

/// Central GoRouter configuration.
///
/// Route guards (PIN check, language selection) redirect users
/// to the appropriate setup screens before they can access screening.
///
/// Placeholder pages are used until feature views are implemented.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const _PlaceholderPage(title: 'Onboarding'),
    ),
    GoRoute(
      path: AppRoutes.pinSetup,
      name: 'pinSetup',
      builder: (context, state) => const _PlaceholderPage(title: 'PIN Setup'),
    ),
    GoRoute(
      path: AppRoutes.pinLock,
      name: 'pinLock',
      builder: (context, state) => const _PlaceholderPage(title: 'PIN Lock'),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const _PlaceholderPage(title: 'Home'),
    ),
    GoRoute(
      path: AppRoutes.screening,
      name: 'screening',
      builder: (context, state) => const _PlaceholderPage(title: 'Screening'),
    ),
    GoRoute(
      path: AppRoutes.pathway,
      name: 'pathway',
      builder: (context, state) => const _PlaceholderPage(title: 'Pathway'),
    ),
    GoRoute(
      path: AppRoutes.support,
      name: 'support',
      builder: (context, state) =>
          const _PlaceholderPage(title: 'Support Resources'),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const _PlaceholderPage(title: 'Settings'),
    ),
    GoRoute(
      path: AppRoutes.accessibility,
      name: 'accessibility',
      builder: (context, state) =>
          const _PlaceholderPage(title: 'Accessibility'),
    ),
    GoRoute(
      path: AppRoutes.quickExit,
      name: 'quickExit',
      builder: (context, state) => const _PlaceholderPage(title: 'Calculator'),
    ),
  ],
);

/// Temporary placeholder page used until feature views are built.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title — coming soon',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
