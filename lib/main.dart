import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'modules/dashboard/dashboard_controller.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // CRITICAL: Set URL strategy for clean URLs
  // This enables URLs like /report instead of /#/report
  setUrlStrategy(PathUrlStrategy());

  await initServices();
  runApp(const MyApp());
}

// Initialize services
Future<void> initServices() async {
  // Initialize shared preferences for theme persistence
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  // Set initial theme mode
  Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900), // Design size for desktop/web
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ওসিভি রিপোর্ট পোর্টাল',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          // Router configuration with go_router
          routerConfig: router,

          // Locale configuration (maintained for localization)
          locale: const Locale('bn', 'BD'), // Bengali locale
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          // Bindings for GetX (maintained for existing controllers)
          builder: (context, child) {
            // Initialize GetX bindings
            if (!Get.isRegistered<DashboardController>()) {
              Get.lazyPut<DashboardController>(() => DashboardController());
            }
            return child!;
          },
        );
      },
    );
  }
}
