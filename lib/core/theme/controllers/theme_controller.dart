import 'package:flutter/material.dart';
import '../theme_service.dart';

/// Theme Controller
/// Manages theme state - ViewModel in MVVM architecture
class ThemeController extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();

  bool _isDarkMode = false;
  bool _isInitialized = false;

  /// Current dark mode state
  bool get isDarkMode => _isDarkMode;

  /// Whether the controller has been initialized
  bool get isInitialized => _isInitialized;

  /// Initialize theme controller by loading saved theme preference
  Future<void> init() async {
    if (_isInitialized) return;

    _isDarkMode = await _themeService.getIsDarkMode();
    _isInitialized = true;
    notifyListeners();
  }

  /// Toggle theme between light and dark mode
  Future<void> toggleTheme() async {
    _isDarkMode = await _themeService.toggleTheme();
    notifyListeners();
  }

  /// Set theme mode explicitly
  Future<void> setDarkMode(bool isDarkMode) async {
    if (_isDarkMode == isDarkMode) return;

    _isDarkMode = isDarkMode;
    await _themeService.setDarkMode(isDarkMode);
    notifyListeners();
  }
}
