// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dashboard_controller.dart';
// import '../../../core/theme/app_theme.dart';
// import '../../../data/models/stat_model.dart';

// class DashboardView extends GetView<DashboardController> {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Left Sidebar Menu
//           _buildSidebar(context),
//           // Main Content Area
//           Expanded(
//             child: _buildContent(context),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSidebar(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       width: 250,
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
//         border: Border(
//           right: BorderSide(
//             color: isDark ? AppColors.darkBorderColor : AppColors.lightBorderColor,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.all(20),
//             child: Text(
//               'ওসিভি পোর্টাল',
//               style: TextStyle(
//                 color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const Divider(height: 1),
//           // Theme Toggle
//           _buildThemeToggle(context, isDark),
//           const Divider(height: 1),
//           // Menu Items
//           Obx(() => Column(
//                 children: List.generate(controller.menuOptions.length, (index) {
//                   final isSelected = controller.selectedMenuIndex.value == index;
//                   return _buildMenuItem(
//                     context,
//                     controller.menuOptions[index],
//                     isSelected,
//                     () => controller.selectMenuItem(index),
//                   );
//                 }),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildThemeToggle(BuildContext context, bool isDark) {
//     return InkWell(
//       onTap: () {
//         Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           children: [
//             Icon(
//               isDark ? Icons.light_mode : Icons.dark_mode,
//               color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//               size: 22,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 isDark ? 'লাইট মোড' : 'ডার্ক মোড',
//                 style: TextStyle(
//                   color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(
//     BuildContext context,
//     MenuOption option,
//     bool isSelected,
//     VoidCallback onTap,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? (isDark ? AppColors.darkPrimary.withValues(alpha: 0.15) : AppColors.lightPrimary.withValues(alpha: 0.15))
//               : Colors.transparent,
//           border: Border(
//             left: BorderSide(
//               color: isSelected
//                   ? (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
//                   : Colors.transparent,
//               width: 3,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             _getIcon(option.icon, isDark),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 option.title,
//                 style: TextStyle(
//                   color: isSelected
//                       ? (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
//                       : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
//                   fontSize: 14,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getIcon(String iconName, bool isDark) {
//     IconData iconData;
//     switch (iconName) {
//       case 'dashboard':
//         iconData = Icons.dashboard;
//         break;
//       case 'description':
//         iconData = Icons.description;
//         break;
//       case 'settings':
//         iconData = Icons.settings;
//         break;
//       default:
//         iconData = Icons.circle;
//     }
//     return Icon(
//       iconData,
//       color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//       size: 22,
//     );
//   }

//   Widget _buildContent(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
//       child: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (controller.hasError.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.error_outline,
//                   size: 64,
//                   color: AppColors.error,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'ত্রুটি হয়েছে',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   controller.errorMessage.value,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: controller.refreshStatistics,
//                   child: const Text('পুনরায় চেষ্টা করুন'),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // Page Header
//             Obx(() => Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     controller.selectedMenu.title,
//                     style: Theme.of(context).textTheme.displayMedium,
//                   ),
//                 )),
//             // Cards Grid
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 // Responsive crossAxisCount based on screen width
//                 int crossAxisCount = 4;
//                 if (constraints.maxWidth < 600) {
//                   crossAxisCount = 1;
//                 } else if (constraints.maxWidth < 900) {
//                   crossAxisCount = 2;
//                 } else if (constraints.maxWidth < 1200) {
//                   crossAxisCount = 3;
//                 }

//                 return GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 1.6,
//                   ),
//                   itemCount: controller.statsCount,
//                   itemBuilder: (context, index) {
//                     return StatCard(
//                       stat: controller.getStatByIndex(index),
//                       index: index,
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// class StatCard extends StatelessWidget {
//   final StatModel stat;
//   final int index;

//   const StatCard({
//     super.key,
//     required this.stat,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Card Header with Badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//               decoration: BoxDecoration(
//                 color: isDark
//                     ? AppColors.success.withValues(alpha: 0.2)
//                     : AppColors.successLight,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 stat.approvedLabel,
//                 style: TextStyle(
//                   color: AppColors.success,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             const SizedBox(height: 6),
//             // Approved Count
//             Text(
//               stat.approved,
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                     fontSize: 18,
//                   ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             // OCV Label
//             Text(
//               stat.ocvLabel,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                   ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 2),
//             // OCV Value
//             Text(
//               stat.ocv,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.info,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 6),
//             // ICPV Label
//             Text(
//               stat.icpvLabel,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                   ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 2),
//             // ICPV Value
//             Text(
//               stat.icpv,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.warning,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
