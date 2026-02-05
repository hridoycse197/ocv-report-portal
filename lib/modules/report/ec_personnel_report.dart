import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EcPersonnelReport extends StatefulWidget {
  /// Initial menu index based on URL route
  final int initialIndex;

  const EcPersonnelReport({super.key, this.initialIndex = 0});

  @override
  State<EcPersonnelReport> createState() => _EcPersonnelReportState();
}

class _EcPersonnelReportState extends State<EcPersonnelReport> {
  late int _selectedMenuIndex;
  bool _isDarkMode = false;

  /// Route mapping for navigation
  static const Map<int, String> _routes = {
    0: '/dashboard',
    1: '/report',
    2: '/settings',
  };

  @override
  void initState() {
    super.initState();
    _selectedMenuIndex = widget.initialIndex;
  }

  /// Navigate to a menu item and update URL
  void _selectMenu(int index) {
    if (_selectedMenuIndex != index) {
      setState(() {
        _selectedMenuIndex = index;
      });
      // Update URL using go_router
      context.go(_routes[index]!);
    }
  }

  final List<MenuOption> _menuOptions = [
    MenuOption(title: 'ড্যাশবোর্ড', icon: Icons.dashboard),
    MenuOption(title: 'রিপোর্ট', icon: Icons.description),
    MenuOption(title: 'সেটিংস', icon: Icons.settings),
  ];

  // Breakpoint for showing sidebar as drawer
  static const double _sidebarBreakpoint = 800;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < _sidebarBreakpoint;

    return Theme(
      data: _isDarkMode ? _darkTheme : _lightTheme,
      child: Scaffold(
        backgroundColor: _isDarkMode
            ? Colors.grey.shade900
            : Colors.grey.shade100,
        // Conditionally add drawer only on mobile/tablet
        drawer: isMobile ? _buildDrawer(context) : null,
        appBar: isMobile
            ? AppBar(
                backgroundColor: _isDarkMode
                    ? Colors.grey.shade900
                    : Colors.white,
                title: Text(
                  'ওসিভি পোর্টাল',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black87,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: _isDarkMode ? Colors.white : Colors.black87,
                ),
                elevation: 0,
              )
            : null,
        body: isMobile
            ? _buildContent(context)
            : Row(
                children: [
                  // Left Sidebar Menu (desktop only)
                  _buildSidebar(context),
                  // Main Content Area
                  Expanded(child: _buildContent(context)),
                ],
              ),
      ),
    );
  }

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250.w,
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
        border: Border(
          right: BorderSide(
            color: _isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20.w),
            child: Text(
              'ওসিভি পোর্টাল',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black87,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(height: 1.h),
          // Menu Items
          ...List.generate(_menuOptions.length, (index) {
            final isSelected = _selectedMenuIndex == index;
            return _buildMenuItem(
              context,
              _menuOptions[index],
              isSelected,
              () => _selectMenu(index),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
        child: Column(
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'ওসিভি পোর্টাল',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.h),
            // Menu Items
            ...List.generate(_menuOptions.length, (index) {
              final isSelected = _selectedMenuIndex == index;
              return _buildMenuItem(
                context,
                _menuOptions[index],
                isSelected,
                () {
                  Navigator.pop(context); // Close drawer after selection
                  _selectMenu(index);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    MenuOption option,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final primaryColor = _isDarkMode
        ? Colors.blue.shade300
        : Colors.blue.shade700;

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
              option.icon,
              color: isSelected
                  ? primaryColor
                  : (_isDarkMode ? Colors.white70 : Colors.black54),
              size: 22.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                option.title,
                style: TextStyle(
                  color: isSelected
                      ? primaryColor
                      : (_isDarkMode ? Colors.white : Colors.black87),
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

  Widget _buildContent(BuildContext context) {
    return Container(
      color: _isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Page Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  _menuOptions[_selectedMenuIndex].title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              // Theme Toggle Button
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: IconButton(
                  onPressed: _toggleTheme,
                  icon: Icon(
                    _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: _isDarkMode ? Colors.white : Colors.black54,
                    size: 24.r,
                  ),
                  tooltip: _isDarkMode ? 'লাইট মোড' : 'ডার্ক মোড',
                  style: IconButton.styleFrom(
                    backgroundColor: _isDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    padding: EdgeInsets.all(12.w),
                  ),
                ),
              ),
            ],
          ),
          // Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive crossAxisCount based on screen width
              int crossAxisCount = 4;
              if (constraints.maxWidth < 600) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 900) {
                crossAxisCount = 2;
              } else if (constraints.maxWidth < 1200) {
                crossAxisCount = 3;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.6,
                ),
                itemCount: 100,
                itemBuilder: (context, index) => _StatCard(index: index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final int index;

  const _StatCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Card Header with Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'অনুমোদিত',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 6.h),
            // Approved Count
            Text(
              '১,৫২৮,১৩১',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // OCV Label
            Text(
              'ওসিভি',
              style: TextStyle(
                fontSize: 11.sp,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // OCV Value
            Text(
              '৭৬৭,২৩৩',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            // ICPV Label
            Text(
              'আইসিপিভি',
              style: TextStyle(
                fontSize: 11.sp,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // ICPV Value
            Text(
              '৭৬০,৮৯৮',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuOption {
  final String title;
  final IconData icon;

  MenuOption({required this.title, required this.icon});
}
