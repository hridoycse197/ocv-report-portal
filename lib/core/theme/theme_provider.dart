import 'package:flutter/material.dart';
import 'controllers/theme_controller.dart';

/// Theme Provider
/// InheritedWidget for providing ThemeController to the widget tree
class ThemeProvider extends InheritedWidget {
  final ThemeController controller;

  const ThemeProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Get ThemeController from context
  static ThemeController of(BuildContext context) {
    final ThemeProvider? result =
        context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    if (result == null) {
      throw FlutterError(
        'ThemeProvider.of() called with a context that does not contain a ThemeProvider.\n'
        'No ThemeProvider ancestor could be found starting from the context that was passed to '
        'ThemeProvider.of().\n'
        'This can happen if you have not wrapped your app with ThemeProvider, or if the context '
        'you are using comes from a widget that is outside the ThemeProvider scope.',
      );
    }
    return result.controller;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) =>
      controller != oldWidget.controller;
}
