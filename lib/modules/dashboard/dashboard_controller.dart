import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/stat_model.dart';
import '../../../data/services/api_service.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();

  // Observable variables
  final RxList<StatModel> statistics = <StatModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt selectedMenuIndex = 0.obs;

  // Menu options
  final RxList<MenuOption> menuOptions = MenuOption.getSidebarOptions().obs;

  @override
  void onInit() {
    super.onInit();
    loadStatistics();
  }

  // Load statistics from API
  Future<void> loadStatistics() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      // TODO: Uncomment this when API is ready
      // statistics.value = await _apiService.getStatistics();

      // For now, use mock data
      await Future.delayed(const Duration(seconds: 1));
      statistics.value = StatModel.mockList(count: 100);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      // Load mock data on error
      statistics.value = StatModel.mockList(count: 100);
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh statistics
  Future<void> refreshStatistics() async {
    await loadStatistics();
  }

  // Select menu item
  void selectMenuItem(int index) {
    if (index >= 0 && index < menuOptions.length) {
      selectedMenuIndex.value = index;
    }
  }

  // Get current selected menu
  MenuOption get selectedMenu => menuOptions[selectedMenuIndex.value];

  // Get statistics count
  int get statsCount => statistics.length;

  // Get stat by index
  StatModel getStatByIndex(int index) {
    if (index >= 0 && index < statistics.length) {
      return statistics[index];
    }
    return StatModel.mock();
  }

  // Search statistics (for future implementation)
  void searchStatistics(String query) {
    // TODO: Implement search functionality
  }

  // Filter statistics (for future implementation)
  void filterStatistics(Map<String, dynamic> filters) {
    // TODO: Implement filter functionality
  }
}
