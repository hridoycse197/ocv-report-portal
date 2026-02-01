import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocv_report_portal/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'modules/dashboard/dashboard_controller.dart';
import 'modules/dashboard/dashboard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return GetMaterialApp(
      title: 'ওসিভি রিপোর্ট পোর্টাল',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Enable transitions
      defaultTransition: Transition.fadeIn,
      opaqueRoute: Get.isOpaqueRouteDefault,
      // Smart management
      smartManagement: SmartManagement.full,
      // Locale
      locale: const Locale('bn', 'BD'), // Bengali locale
      fallbackLocale: const Locale('en', 'US'),
      // Home
      home: const DashboardPage(),
      // Bindings
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
    );
  }
}
