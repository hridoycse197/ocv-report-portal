import 'package:shared_preferences/shared_preferences.dart';

/// Theme Service
/// Handles theme persistence and business logic
class ThemeService {
  static const String _isDarkModeKey = 'isDarkMode';

  /// Get current theme mode from storage
  Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  /// Save theme mode to storage
  Future<void> setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  /// Toggle theme mode
  Future<bool> toggleTheme() async {
    final current = await getIsDarkMode();
    final newValue = !current;
    await setDarkMode(newValue);
    return newValue;
  }
}
