// theme/light_theme.dart
import 'package:flutter/material.dart';

class LightTheme {
  // Color scheme for light theme
  // Uses Material Design color system
  final ColorScheme _colorScheme = const ColorScheme.light(
    primary: Colors.cyan, // Primary brand color
    onPrimary: Colors.white, // Text on primary color
    secondary: Color(0xFF3F979B), // Secondary accent color
    onSecondary: Colors.white, // Text on secondary color
    surface: Colors.white, // Surface elements (cards, dialogs)
    onSurface: Colors.black87, // Text on background
    error: Color(0xFFE63946), // Error color
    onError: Colors.white, // Text on error color
  );

  // Typography system for light theme
  // Defines consistent text styles across the app
  final TextTheme _textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
  );

  // Input field styling
  // Consistent look for all text fields in the app
  final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
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

  // Elevated button styling
  // Consistent primary button style
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

  // Text button styling
  // For secondary actions
  final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF4361EE),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // Outlined button styling
  // For actions that need to stand out but not as much as primary buttons
  final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF4361EE),
      side: const BorderSide(color: Color(0xFF4361EE), width: 2),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // Card styling
  // Consistent card design throughout the app
  final CardThemeData _cardTheme = CardThemeData(
    color: Colors.white,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.05),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.all(12),
  );

  // AppBar styling
  // Top app bar design
  final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );

  // Bottom navigation styling
  // Consistent bottom navigation design
  final BottomNavigationBarThemeData _bottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4361EE),
        unselectedItemColor: Colors.grey,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      );

  // List tile styling
  // For consistent list items
  final ListTileThemeData _listTileTheme = const ListTileThemeData(
    iconColor: Color(0xFF4361EE),
    textColor: Colors.black87,
  );

  // Main theme data object
  // Combines all theme components into one cohesive theme
  ThemeData get themeData => ThemeData(
    useMaterial3: true, // Enable Material Design 3
    brightness: Brightness.light, // Light theme brightness
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
    scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Background
    fontFamily: 'Roboto', // Default font family
  );
}
