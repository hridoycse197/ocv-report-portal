import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';
import '../modules/dashboard/dashboard_page.dart';
import '../modules/ec_personnel/ec_personnel_page.dart';
import '../modules/settings/settings_page.dart';

/// Route names for type-safe navigation
class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String ecPersonnel = '/ec-personnel';
  static const String settings = '/settings';
  static const String notFound = '/404';
}

/// Router configuration for the app
final router = GoRouter(
  // Initial route - redirect to dashboard
  initialLocation: AppRoutes.dashboard,

  // Enable debug logging for navigation (disable in production)
  debugLogDiagnostics: true,

  // Routes configuration
  routes: [
    // Dashboard route - default page
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    // EC Personnel route
    GoRoute(
      path: AppRoutes.ecPersonnel,
      name: 'ec-personnel',
      builder: (context, state) => const EcPersonnelPage(),
    ),

    // Settings route
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),

    // Root redirect to dashboard
    GoRoute(
      path: '/',
      redirect: (context, state) => AppRoutes.dashboard,
    ),
  ],

  // Error page for invalid routes (404)
  errorBuilder: (context, state) => const NotFoundPage(),
);

/// 404 Not Found Page
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text(
                '404',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.pageNotFound,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoutes.dashboard),
              icon: const Icon(Icons.home),
              label: Text(l10n.goToDashboard),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
