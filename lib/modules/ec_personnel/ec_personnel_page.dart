import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ocv_report_portal/core/theme/theme_provider.dart';
import 'package:ocv_report_portal/core/theme/controllers/theme_controller.dart';
import 'package:ocv_report_portal/core/widgets/app_drawer.dart';
import 'package:ocv_report_portal/core/widgets/app_sidebar.dart';
import 'package:ocv_report_portal/core/widgets/theme_toggle_button.dart';
import 'package:ocv_report_portal/core/widgets/toggle_bar.dart';
import 'package:ocv_report_portal/l10n/app_localizations.dart';

/// EC Personnel Report Page
/// নির্বাচনের কাজে নিয়োজিত কর্মকর্তাদের নথিভুক্তি প্রতিবেদন
class EcPersonnelPage extends StatefulWidget {
  const EcPersonnelPage({super.key});

  @override
  State<EcPersonnelPage> createState() => _EcPersonnelPageState();
}

class _EcPersonnelPageState extends State<EcPersonnelPage> {
  late final ThemeController _themeController;
  String _selectedDistrict = 'all';

  /// All 64 districts of Bangladesh with Bengali and English names
  List<DistrictData> get _allDistricts => [
    // Dhaka Division
    DistrictData(name: 'ঢাকা', nameEn: 'Dhaka', totalWorkers: '৩২,৪৪৫', registered: '০', notRegistered: '৩২,৪৪৫'),
    DistrictData(name: 'ফরিদপুর', nameEn: 'Faridpur', totalWorkers: '২৮,৩৩৪', registered: '০', notRegistered: '২৮,৩৩৪'),
    DistrictData(name: 'গাজীপুর', nameEn: 'Gazipur', totalWorkers: '২০,৭৮৩', registered: '০', notRegistered: '২০,৭৮৩'),
    DistrictData(name: 'গোপালগঞ্জ', nameEn: 'Gopalganj', totalWorkers: '৪,৮৯২', registered: '০', notRegistered: '৪,৮৯২'),
    DistrictData(name: 'কিশোরগঞ্জ', nameEn: 'Kishoreganj', totalWorkers: '৩২,১৪৫', registered: '০', notRegistered: '৩২,১৪৫'),
    DistrictData(name: 'মাদারীপুর', nameEn: 'Madaripur', totalWorkers: '২১,৬৭৮', registered: '০', notRegistered: '২১,৬৭৮'),
    DistrictData(name: 'মানিকগঞ্জ', nameEn: 'Manikganj', totalWorkers: '১৯,৪৫৬', registered: '০', notRegistered: '১৯,৪৫৬'),
    DistrictData(name: 'মুন্সিগঞ্জ', nameEn: 'Munshiganj', totalWorkers: '৪৫,৭৮৯', registered: '০', notRegistered: '৪৫,৭৮৯'),
    DistrictData(name: 'নারায়ণগঞ্জ', nameEn: 'Narayanganj', totalWorkers: '১০,০২০', registered: '০', notRegistered: '১০,০২০'),
    DistrictData(name: 'নরসিংদী', nameEn: 'Narsingdi', totalWorkers: '৩,৪৫৬', registered: '০', notRegistered: '৩,৪৫৬'),
    DistrictData(name: 'নারায়ণগঞ্জ', nameEn: 'Narayanganj', totalWorkers: '৫,২৩৪', registered: '০', notRegistered: '৫,২৩৪'),
    DistrictData(name: 'রাজবাড়ী', nameEn: 'Rajbari', totalWorkers: '৪,৮৯২', registered: '০', notRegistered: '৪,৮৯২'),
    DistrictData(name: 'শরীয়তপুর', nameEn: 'Shariatpur', totalWorkers: '২৭,৮৫৭', registered: '০', notRegistered: '২৭,৮৫৭'),
    DistrictData(name: 'টাঙ্গাইল', nameEn: 'Tangail', totalWorkers: '২৪,৮৮৯', registered: '০', notRegistered: '২৪,৮৮৯'),

    // Chittagong Division
    DistrictData(name: 'ব্রাহ্মণবাড়িয়া', nameEn: 'Brahmanbaria', totalWorkers: '৩৮,৭৯১', registered: '০', notRegistered: '৩৮,৭৯১'),
    DistrictData(name: 'চাঁদপুর', nameEn: 'Chandpur', totalWorkers: '২৭,৪৬৫', registered: '০', notRegistered: '২৭,৪৬৫'),
    DistrictData(name: 'চট্টগ্রাম', nameEn: 'Chittagong', totalWorkers: '২৭,৯৮৮', registered: '০', notRegistered: '২৭,৯৮৮'),
    DistrictData(name: 'কুমিল্লা', nameEn: 'Comilla', totalWorkers: '৩১,৮২৪', registered: '০', notRegistered: '৩১,৮২৪'),
    DistrictData(name: 'কক্সবাজার', nameEn: 'Coxsbazar', totalWorkers: '৪০,৪৭৩', registered: '০', notRegistered: '৪০,৪৭৩'),
    DistrictData(name: 'ফেনী', nameEn: 'Feni', totalWorkers: '২৯,৬৭৭', registered: '০', notRegistered: '২৯,৬৭৭'),
    DistrictData(name: 'খাগড়াছড়ি', nameEn: 'Khagrachari', totalWorkers: '১৭,৪৩৫', registered: '০', notRegistered: '১৭,৪৩৫'),
    DistrictData(name: 'লক্ষ্মীপুর', nameEn: 'Lakshmipur', totalWorkers: '১৭,২৬৭', registered: '০', notRegistered: '১৭,২৬৭'),
    DistrictData(name: 'নোয়াখালী', nameEn: 'Noakhali', totalWorkers: '১০,৬৩৩', registered: '০', notRegistered: '১০,৬৩৩'),
    DistrictData(name: 'রাঙ্গামাটি', nameEn: 'Rangamati', totalWorkers: '১৬,৯৫৪', registered: '০', notRegistered: '১৬,৯৫৪'),
    DistrictData(name: 'বান্দরবান', nameEn: 'Bandarban', totalWorkers: '২৪,৩৫৪', registered: '০', notRegistered: '২৪,৩৫৪'),

    // Rajshahi Division
    DistrictData(name: 'বগুড়া', nameEn: 'Bogra', totalWorkers: '৩৫,৮৬৩', registered: '০', notRegistered: '৩৫,৮৬৩'),
    DistrictData(name: 'জয়পুরহাট', nameEn: 'Joypurhat', totalWorkers: '২০,৩৬৪', registered: '০', notRegistered: '২০,৩৬৪'),
    DistrictData(name: 'নওগাঁ', nameEn: 'Naogaon', totalWorkers: '১৬,৭৫৮', registered: '০', notRegistered: '১৬,৭৫৮'),
    DistrictData(name: 'নাটোর', nameEn: 'Natore', totalWorkers: '১৮,২৭৩', registered: '০', notRegistered: '১৮,২৭৩'),
    DistrictData(name: 'নওগাঁ', nameEn: 'Chapainawabganj', totalWorkers: '৩৭,৯৭৪', registered: '০', notRegistered: '৩৭,৯৭৪'),
    DistrictData(name: 'পাবনা', nameEn: 'Pabna', totalWorkers: '৪৬,৫৫৮', registered: '০', notRegistered: '৪৬,৫৫৮'),
    DistrictData(name: 'রাজশাহী', nameEn: 'Rajshahi', totalWorkers: '৩৭,৭৪৯', registered: '০', notRegistered: '৩৭,৭৪৯'),
    DistrictData(name: 'সিরাজগঞ্জ', nameEn: 'Sirajganj', totalWorkers: '২৪,৪২৬', registered: '০', notRegistered: '২৪,৪২৬'),

    // Khulna Division
    DistrictData(name: 'বাগেরহাট', nameEn: 'Bagerhat', totalWorkers: '২৩,৬৯২', registered: '০', notRegistered: '২৩,৬৯২'),
    DistrictData(name: 'চুয়াডাঙ্গা', nameEn: 'Chuadanga', totalWorkers: '২৯,৭৯৯', registered: '০', notRegistered: '২৯,৭৯৯'),
    DistrictData(name: 'যশোর', nameEn: 'Jessore', totalWorkers: '২৮,৮৫৬', registered: '০', notRegistered: '২৮,৮৫৬'),
    DistrictData(name: 'ঝিনাইদহ', nameEn: 'Jhenaidah', totalWorkers: '২১,৬৬৬', registered: '০', notRegistered: '২১,৬৬৬'),
    DistrictData(name: 'খুলনা', nameEn: 'Khulna', totalWorkers: '৩১,৪৪৬', registered: '০', notRegistered: '৩১,৪৪৬'),
    DistrictData(name: 'কুষ্টিয়া', nameEn: 'Kushtia', totalWorkers: '২৭,৭৬৬', registered: '০', notRegistered: '২৭,৭৬৬'),
    DistrictData(name: 'মাগুরা', nameEn: 'Magura', totalWorkers: '২০,৪৪৮', registered: '০', notRegistered: '২০,৪৪৮'),
    DistrictData(name: 'মেহেরপুর', nameEn: 'Meherpur', totalWorkers: '১৮,৩৮৬', registered: '০', notRegistered: '১৮,৩৮৬'),
    DistrictData(name: 'নড়াইল', nameEn: 'Narail', totalWorkers: '২০,৫৫৪', registered: '০', notRegistered: '২০,৫৫৪'),
    DistrictData(name: 'সাতক্ষীরা', nameEn: 'Satkhira', totalWorkers: '২৬,৭৮৯', registered: '০', notRegistered: '২৬,৭৮৯'),

    // Barisal Division
    DistrictData(name: 'বরগুনা', nameEn: 'Barguna', totalWorkers: '৬,৭৮৪', registered: '০', notRegistered: '৬,৭৮৪'),
    DistrictData(name: 'বরিশাল', nameEn: 'Barisal', totalWorkers: '১৪,৬৫২', registered: '০', notRegistered: '১৪,৬৫২'),
    DistrictData(name: 'ভোলা', nameEn: 'Bhola', totalWorkers: '৮,৯৬৩', registered: '০', notRegistered: '৮,৯৬৩'),
    DistrictData(name: 'ঝালকাঠি', nameEn: 'Jhalokati', totalWorkers: '৫,৪২৬', registered: '০', notRegistered: '৫,৪২৬'),
    DistrictData(name: 'পটুয়াখালী', nameEn: 'Patuakhali', totalWorkers: '১৫,৬৭৭', registered: '০', notRegistered: '১৫,৬৭৭'),
    DistrictData(name: 'পিরোজপুর', nameEn: 'Pirojpur', totalWorkers: '৭,২৩৪', registered: '০', notRegistered: '৭,২৩৪'),

    // Sylhet Division
    DistrictData(name: 'হবিগঞ্জ', nameEn: 'Habiganj', totalWorkers: '১২,৫৬৭', registered: '০', notRegistered: '১২,৫৬৭'),
    DistrictData(name: 'মৌলভীবাজার', nameEn: 'Moulvibazar', totalWorkers: '১৪,৮৯২', registered: '০', notRegistered: '১৪,৮৯২'),
    DistrictData(name: 'সুনামগঞ্জ', nameEn: 'Sunamganj', totalWorkers: '১৩,৭৪৫', registered: '০', notRegistered: '১৩,৭৪৫'),
    DistrictData(name: 'সিলেট', nameEn: 'Sylhet', totalWorkers: '২২,৩৪৫', registered: '০', notRegistered: '২২,৩৪৫'),

    // Rangpur Division
    DistrictData(name: 'দিনাজপুর', nameEn: 'Dinajpur', totalWorkers: '২৮,৪৫৬', registered: '০', notRegistered: '২৮,৪৫৬'),
    DistrictData(name: 'গাইবান্ধা', nameEn: 'Gaibandha', totalWorkers: '১৯,৩৫৪', registered: '০', notRegistered: '১৯,৩৫৪'),
    DistrictData(name: 'কুড়িগ্রাম', nameEn: 'Kurigram', totalWorkers: '১৬,৭৮৯', registered: '০', notRegistered: '১৬,৭৮৯'),
    DistrictData(name: 'লালমনিরহাট', nameEn: 'Lalmonirhat', totalWorkers: '১৪,২৩৪', registered: '০', notRegistered: '১৪,২৩৪'),
    DistrictData(name: 'নীলফামারী', nameEn: 'Nilphamari', totalWorkers: '১৫,৬৭৮', registered: '০', notRegistered: '১৫,৬৭৮'),
    DistrictData(name: 'পঞ্চগড়', nameEn: 'Panchagarh', totalWorkers: '৯,৪৫৬', registered: '০', notRegistered: '৯,৪৫৬'),
    DistrictData(name: 'রংপুর', nameEn: 'Rangpur', totalWorkers: '২৫,৬৭৮', registered: '০', notRegistered: '২৫,৬৭৮'),
    DistrictData(name: 'ঠাকুরগাঁও', nameEn: 'Thakurgaon', totalWorkers: '১১,২৩৪', registered: '০', notRegistered: '১১,২৩৪'),

    // Mymensingh Division
    DistrictData(name: 'জামালপুর', nameEn: 'Jamalpur', totalWorkers: '১৮,৫৬৭', registered: '০', notRegistered: '১৮,৫৬৭'),
    DistrictData(name: 'ময়মনসিংহ', nameEn: 'Mymensingh', totalWorkers: '৩২,১২৩', registered: '০', notRegistered: '৩২,১২৩'),
    DistrictData(name: 'নেত্রকোণা', nameEn: 'Netrokona', totalWorkers: '১৭,৮৯০', registered: '০', notRegistered: '১৭,৮৯০'),
    DistrictData(name: 'শেরপুর', nameEn: 'Sherpur', totalWorkers: '১৩,৪৫৬', registered: '০', notRegistered: '১৩,৪৫৬'),
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
              backgroundColor:
                  isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              drawer: isMobile
                  ? AppDrawer(currentPath: currentPath, isDarkMode: isDarkMode)
                  : null,
              appBar: isMobile
                  ? AppBar(
                      backgroundColor:
                          isDarkMode ? Colors.grey.shade900 : Colors.white,
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
    // Calculate totals from all districts
    final totalWorkers = _calculateTotal(_allDistricts, (d) => d.totalWorkers);
    final totalRegistered = _calculateTotal(_allDistricts, (d) => d.registered);
    final totalNotRegistered = _calculateTotal(_allDistricts, (d) => d.notRegistered);

    return Container(
      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            if (!isMobile) ToggleBar(themeController: _themeController, currentPageTitle: l10n.reportOfficers),
            if (!isMobile) SizedBox(height: 20.h),
            // Title Section
            Text(
              l10n.reportOfficers,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.reportOfficersDesc,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),

            // Search Field
            _SearchDropdown(
              isDarkMode: isDarkMode,
              selectedDistrict: _selectedDistrict,
              districts: _allDistricts,
              onChanged: (value) {
                setState(() {
                  _selectedDistrict = value;
                });
              },
              l10n: l10n,
            ),
            SizedBox(height: 16.h),

            // Input Fields Row
            Row(
              children: [
                Expanded(
                  child: _InputField(
                    label: l10n.totalWorkers,
                    value: totalWorkers,
                    borderColor: Colors.grey.shade400,
                    isDarkMode: isDarkMode,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _InputField(
                    label: l10n.totalRegistered,
                    value: totalRegistered,
                    borderColor: Colors.purple,
                    isDarkMode: isDarkMode,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _InputField(
                    label: l10n.notRegistered,
                    value: totalNotRegistered,
                    borderColor: Colors.red,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // District Grid
            _buildDistrictGrid(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildDistrictGrid(bool isDarkMode) {
    // Filter districts based on selection
    List<DistrictData> displayDistricts = _selectedDistrict == 'all'
        ? _allDistricts
        : _allDistricts.where((d) => d.name == _selectedDistrict || d.nameEn == _selectedDistrict).toList();

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 8.h,
      crossAxisSpacing: 8.w,
      padding: EdgeInsets.zero,
      childAspectRatio: 2.2,
      children: displayDistricts
          .map(
            (district) => _DistrictCard(
              district: district,
              isDarkMode: isDarkMode,
            ),
          )
          .toList(),
    );
  }

  String _calculateTotal(List<DistrictData> districts, String Function(DistrictData) getter) {
    int total = 0;
    for (var district in districts) {
      String value = getter(district);
      // Convert Bengali numerals to int
      value = value.replaceAll(',', '');
      // Simple Bengali to digit conversion
      const bengaliDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
      int multiplier = 1;
      for (int i = value.length - 1; i >= 0; i--) {
        int digit = bengaliDigits.indexOf(value[i]);
        total += digit * multiplier;
        multiplier *= 10;
      }
    }
    return total.toString();
  }
}

/// District Data Model
class DistrictData {
  final String name;
  final String nameEn;
  final String totalWorkers;
  final String registered;
  final String notRegistered;

  const DistrictData({
    required this.name,
    required this.nameEn,
    required this.totalWorkers,
    required this.registered,
    required this.notRegistered,
  });
}

/// Search Dropdown Widget
class _SearchDropdown extends StatelessWidget {
  final bool isDarkMode;
  final String selectedDistrict;
  final List<DistrictData> districts;
  final Function(String) onChanged;
  final AppLocalizations l10n;

  const _SearchDropdown({
    required this.isDarkMode,
    required this.selectedDistrict,
    required this.districts,
    required this.onChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isBengali = l10n.localeName == 'bn';
    final displayText = selectedDistrict == 'all'
        ? (isBengali ? 'সকল জেলা' : 'All Districts')
        : (isBengali
            ? districts.firstWhere(
                (d) => d.name == selectedDistrict || d.nameEn == selectedDistrict,
                orElse: () => districts[0],
              ).name
            : districts.firstWhere(
                (d) => d.name == selectedDistrict || d.nameEn == selectedDistrict,
                orElse: () => districts[0],
              ).nameEn);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300, width: 1.w),
      ),
      child: InkWell(
        onTap: () => _showDistrictPicker(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: isDarkMode ? Colors.white60 : Colors.black54,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }

  void _showDistrictPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final l10n = AppLocalizations.of(context)!;
        final isBengali = l10n.localeName == 'bn';
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          constraints: BoxConstraints(maxHeight: screenHeight * 0.7),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBengali ? 'জেলা নির্বাচন করুন' : 'Select District',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                      color: isDark ? Colors.white : Colors.black54,
                    ),
                  ],
                ),
              ),
              // District List
              Flexible(
                child: ListView.builder(
                  itemCount: districts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // "All Districts" option
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.list,
                          size: 20.r,
                          color: Colors.blue,
                        ),
                        title: Text(
                          isBengali ? 'সকল জেলা' : 'All Districts',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        onTap: () {
                          onChanged('all');
                          Navigator.pop(context);
                        },
                      );
                    }

                    final district = districts[index - 1];
                    final displayName = isBengali ? district.name : district.nameEn;
                    return ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.location_on,
                        size: 20.r,
                        color: Colors.grey,
                      ),
                      title: Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      onTap: () {
                        onChanged(isBengali ? district.name : district.nameEn);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Input Field Widget
class _InputField extends StatelessWidget {
  final String label;
  final String value;
  final Color borderColor;
  final bool isDarkMode;

  const _InputField({
    required this.label,
    required this.value,
    required this.borderColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor, width: 2.w),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

/// District Card Widget
class _DistrictCard extends StatelessWidget {
  final DistrictData district;
  final bool isDarkMode;

  const _DistrictCard({required this.district, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isBengali = l10n.localeName == 'bn';

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // District Name
          Text(
            isBengali ? district.name : district.nameEn,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: 6.h),

          // Stats
          _StatRow(
            label: l10n.totalWorkers,
            value: district.totalWorkers,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 3.h),
          _StatRow(
            label: l10n.totalRegistered,
            value: district.registered,
            valueColor: Colors.green,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 3.h),
          _StatRow(
            label: l10n.notRegistered,
            value: district.notRegistered,
            valueColor: Colors.red,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 6.h),

          // District Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              l10n.district,
              style: TextStyle(
                fontSize: 9.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat Row Widget
class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool isDarkMode;

  const _StatRow({
    required this.label,
    required this.value,
    this.valueColor = const Color(0xFF000000),
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
