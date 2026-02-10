import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ocv_report_portal/core/theme/theme_provider.dart';
import 'package:ocv_report_portal/core/theme/controllers/theme_controller.dart';
import 'package:ocv_report_portal/core/widgets/app_drawer.dart';
import 'package:ocv_report_portal/core/widgets/app_sidebar.dart';
import 'package:ocv_report_portal/core/widgets/theme_toggle_button.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';
import 'package:ocv_report_portal/router/router.dart';

import '../../core/widgets/toggle_bar.dart';

/// Dashboard Page with integrated sidebar and theme toggle
/// This is the main dashboard page with report cards
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final ThemeController _themeController;

  /// Report card data
  final List<ReportCardData> _reportCards = const [
    ReportCardData(
      titleKey: 'reportOfficers',
      descriptionKey: 'reportOfficersDesc',
      icon: Icons.how_to_vote,
      color: Colors.blue,
    ),
    ReportCardData(
      titleKey: 'reportGovtOfficers',
      descriptionKey: 'reportGovtOfficersDesc',
      icon: Icons.account_balance,
      color: Colors.green,
    ),
    ReportCardData(
      titleKey: 'reportAnsar',
      descriptionKey: 'reportAnsarDesc',
      icon: Icons.security,
      color: Colors.orange,
    ),
    ReportCardData(
      titleKey: 'reportPrisoner',
      descriptionKey: 'reportPrisonerDesc',
      icon: Icons.person_off,
      color: Colors.purple,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _themeController = ThemeController();
    _themeController.init();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < _sidebarBreakpoint;
    final l10n = AppLocalizations.of(context)!;
    final currentPath = GoRouterState.of(context).uri.path;

    return ThemeProvider(
      controller: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, child) {
          final isDarkMode = _themeController.isDarkMode;

          return Theme(
            data: isDarkMode ? _darkTheme : _lightTheme,
            child: Scaffold(
              backgroundColor: isDarkMode
                  ? Colors.grey.shade900
                  : Colors.grey.shade100,
              drawer: isMobile
                  ? AppDrawer(currentPath: currentPath, isDarkMode: isDarkMode)
                  : null,
              appBar: isMobile
                  ? AppBar(
                      backgroundColor: isDarkMode
                          ? Colors.grey.shade900
                          : Colors.white,
                      title: Text(
                        l10n.ocvPortal,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      iconTheme: IconThemeData(
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      elevation: 0,
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: ThemeToggleButton(
                            isDark: isDarkMode,
                            onPressed: _themeController.toggleTheme,
                          ),
                        ),
                      ],
                    )
                  : null,
              body: isMobile
                  ? _buildContent(context, l10n, isDarkMode, isMobile: true)
                  : Row(
                      children: [
                        AppSidebar(
                          currentPath: currentPath,
                          isDarkMode: isDarkMode,
                        ),
                        Expanded(
                          child: _buildContent(context, l10n, isDarkMode, isMobile: false),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  static const double _sidebarBreakpoint = 800;
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    bool isDarkMode, {
    bool isMobile = false,
  }) {
    return Container(
      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Page Header with Theme Toggle (hide on mobile)
          if (!isMobile) ToggleBar(themeController: _themeController),
          if (!isMobile) SizedBox(height: 20.h),
          // Report Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;
              if (constraints.maxWidth < 600) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth >= 1200) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 2.5,
                ),
                itemCount: _reportCards.length,
                itemBuilder: (context, index) => _ReportCard(
                  cardData: _reportCards[index],
                  isDark: isDarkMode,
                  onTap: () => _onReportCardTap(index, l10n),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onReportCardTap(int index, AppLocalizations l10n) {
    if (index == 0) {
      context.go(AppRoutes.ecPersonnel);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.comingSoon),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

/// Report Card Data Model
class ReportCardData {
  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final Color color;

  const ReportCardData({
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.color,
  });
}

/// Report Card Widget
class _ReportCard extends StatelessWidget {
  final ReportCardData cardData;
  final bool isDark;
  final VoidCallback onTap;

  const _ReportCard({
    required this.cardData,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: cardData.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(cardData.icon, color: cardData.color, size: 32.r),
              ),
              SizedBox(width: 16.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getLocalizedString(cardData.titleKey, l10n),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getLocalizedString(cardData.descriptionKey, l10n),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.viewReport,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: cardData.color,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow Icon
              Icon(Icons.arrow_forward_ios, color: cardData.color, size: 16.r),
            ],
          ),
        ),
      ),
    );
  }

  String _getLocalizedString(String key, AppLocalizations l10n) {
    switch (key) {
      case 'reportOfficers':
        return l10n.reportOfficers;
      case 'reportOfficersDesc':
        return l10n.reportOfficersDesc;
      case 'reportGovtOfficers':
        return l10n.reportGovtOfficers;
      case 'reportGovtOfficersDesc':
        return l10n.reportGovtOfficersDesc;
      case 'reportAnsar':
        return l10n.reportAnsar;
      case 'reportAnsarDesc':
        return l10n.reportAnsarDesc;
      case 'reportPrisoner':
        return l10n.reportPrisoner;
      case 'reportPrisonerDesc':
        return l10n.reportPrisonerDesc;
      case 'reportOverseas':
        return l10n.reportOverseas;
      case 'reportOverseasDesc':
        return l10n.reportOverseasDesc;
      default:
        return key;
    }
  }
}
