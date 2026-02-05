import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';
import 'package:ocv_report_portal/router/router.dart';

/// Global App Drawer Widget
/// Reusable drawer component with navigation menu items
class AppDrawer extends StatelessWidget {
  final String currentPath;
  final bool isDarkMode;

  const AppDrawer({
    super.key,
    required this.currentPath,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        child: Column(
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    l10n.ocvPortal,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.h),
            // Menu Items
            _buildMenuItem(
              context,
              Icons.dashboard,
              l10n.dashboard,
              currentPath == AppRoutes.dashboard,
              l10n,
              isDarkMode,
              () {
                Navigator.pop(context);
                context.go(AppRoutes.dashboard);
              },
            ),
            _buildMenuItem(
              context,
              Icons.how_to_vote,
              l10n.reportOfficers,
              currentPath == AppRoutes.ecPersonnel,
              l10n,
              isDarkMode,
              () {
                Navigator.pop(context);
                context.go(AppRoutes.ecPersonnel);
              },
            ),
            _buildMenuItem(
              context,
              Icons.settings,
              l10n.settings,
              currentPath == AppRoutes.settings,
              l10n,
              isDarkMode,
              () {
                Navigator.pop(context);
                context.go(AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    bool isSelected,
    AppLocalizations l10n,
    bool isDarkMode,
    VoidCallback onTap,
  ) {
    final primaryColor = isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? primaryColor : Colors.transparent,
              width: 3.w,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? primaryColor
                  : (isDarkMode ? Colors.white70 : Colors.black54),
              size: 22.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? primaryColor
                      : (isDarkMode ? Colors.white : Colors.black87),
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
