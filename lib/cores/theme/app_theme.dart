// theme/theme_manager.dart
import 'package:flutter_core_utils/cores/theme/dark_theme.dart';
import 'package:flutter_core_utils/cores/theme/light_theme.dart';

// Centralized theme management
// This class makes it easy to access themes from anywhere in the app
class AppThemes {
  // Singleton pattern - provides a single point of access to themes
  static final lightTheme = LightTheme().themeData;
  static final darkTheme = DarkTheme().themeData;
}
