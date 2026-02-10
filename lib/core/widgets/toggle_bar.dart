import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';
import '../theme/controllers/theme_controller.dart';
import 'theme_toggle_button.dart';

class ToggleBar extends StatelessWidget {
  const ToggleBar({
    super.key,
    required ThemeController themeController,
    this.currentPageTitle,
  }) : _themeController = themeController;

  final ThemeController _themeController;
  final String? currentPageTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = _themeController.isDarkMode;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: currentPageTitle != null
                ? _Breadcrumb(
                    dashboard: l10n.dashboard,
                    currentPage: currentPageTitle!,
                    isDarkMode: isDarkMode,
                  )
                : Text(
                    l10n.dashboard,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
          ),
          ThemeToggleButton(
            isDark: isDarkMode,
            onPressed: _themeController.toggleTheme,
          ),
        ],
      ),
    );
  }
}

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb({
    required this.dashboard,
    required this.currentPage,
    required this.isDarkMode,
  });

  final String dashboard;
  final String currentPage;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          dashboard,
          style: TextStyle(
            fontSize: 16.sp,
            color: isDarkMode ? Colors.white54 : Colors.grey.shade600,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Icon(
            Icons.chevron_right,
            size: 20.r,
            color: isDarkMode ? Colors.white54 : Colors.grey.shade600,
          ),
        ),
        Text(
          currentPage,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
