import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocv_report_portal/core/theme/theme_provider.dart';
import 'package:ocv_report_portal/core/widgets/theme_toggle_button.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';

/// Settings Page
/// This is the content area that displays inside the MainPage layout
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final themeController = ThemeProvider.of(context);

    return Container(
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Page Header with Theme Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  l10n.settings,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              // Theme Toggle Button
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: ThemeToggleButton(
                  isDark: isDark,
                  onPressed: themeController.toggleTheme,
                ),
              ),
            ],
          ),
          // Settings Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 80.r,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
                SizedBox(height: 16.h),
                Text(
                  l10n.comingSoon,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
