// theme/dark_theme.dart
import 'package:flutter/material.dart';

class DarkTheme {
  // Color scheme for dark theme
  // Uses darker colors for better readability in low-light conditions
  final ColorScheme _colorScheme = const ColorScheme.dark(
    primary: Color(0xFF4361EE), // Primary brand color
    onPrimary: Colors.white, // Text on primary
    secondary: Color(0xFF3F979B), // Secondary accent
    onSecondary: Colors.white, // Text on secondary
    surface: Color(0xFF1E1E2F), // Surface elements
    onSurface: Colors.white, // Text on background
    error: Color(0xFFE63946), // Error color
    onError: Colors.white, // Text on error
  );

  // Typography system for dark theme (matching light theme structure)
  final TextTheme _textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white70),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  // Input field styling for dark theme (matching light theme structure)
  final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2D2D44),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF4361EE), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE63946), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    hintStyle: const TextStyle(color: Colors.grey),
  );

  // Elevated button styling for dark theme (matching light theme structure)
  final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4361EE),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
    ),
  );

  // Text button styling for dark theme (matching light theme structure)
  final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF4361EE),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // Outlined button styling for dark theme (matching light theme structure)
  final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF4361EE),
      side: const BorderSide(color: Color(0xFF4361EE), width: 2),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // Card styling for dark theme (matching light theme structure)
  final CardThemeData _cardTheme = CardThemeData(
    color: const Color(0xFF1E1E2F),
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.05),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.all(12),
  );

  // AppBar styling for dark theme
  final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: Color(0xFF1E1E2F),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  // Bottom navigation styling for dark theme
  final BottomNavigationBarThemeData _bottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E2F),
        selectedItemColor: Color(0xFF4361EE),
        unselectedItemColor: Colors.grey,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      );
  // List tile styling for dark theme
  final ListTileThemeData _listTileTheme = const ListTileThemeData(
    iconColor: Color(0xFF4361EE),
    textColor: Colors.white,
  );

  // Main theme data object for dark theme
  ThemeData get themeData => ThemeData(
    useMaterial3: true, // Enable Material Design 3
    brightness: Brightness.dark, // Dark theme brightness
    colorScheme: _colorScheme, // Color system
    textTheme: _textTheme, // Typography
    inputDecorationTheme: _inputDecorationTheme, // Input fields
    elevatedButtonTheme: _elevatedButtonTheme, // Primary buttons
    textButtonTheme: _textButtonTheme, // Text buttons
    outlinedButtonTheme: _outlinedButtonTheme, // Outline buttons
    cardTheme: _cardTheme, // Cards
    appBarTheme: _appBarTheme, // App bar
    bottomNavigationBarTheme: _bottomNavigationBarTheme, // Bottom nav
    listTileTheme: _listTileTheme, // List tiles
    scaffoldBackgroundColor: const Color(0xFF121212), // Background
    fontFamily: 'Roboto', // Default font family
  );
}
