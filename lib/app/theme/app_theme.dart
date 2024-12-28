import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const darkGreen = Color(0xFF1B2E1B);
  static const green = Color(0xFF3E5631);
  static const mediumGreen = Color(0xFF687D45);
  static const lightGreen = Color(0xFF93A359);
  static const paleGreen = Color(0xFFBEC96D);
  
  // Light theme specific colors
  static const lightBg = Color(0xFFF8FAF8);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightPrimary = Color(0xFF2E5B2E);
  static const lightSecondary = Color(0xFF4A734A);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      tertiary: mediumGreen,
      background: lightBg,
      surface: lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: darkGreen.withOpacity(0.87),
      onSurface: darkGreen.withOpacity(0.87),
    ),
    scaffoldBackgroundColor: lightBg,
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      shadowColor: lightPrimary.withOpacity(0.2),
      titleTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: lightSurface,
      elevation: 2,
      shadowColor: darkGreen.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
        shadowColor: lightPrimary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: darkGreen.withOpacity(0.87), fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: darkGreen.withOpacity(0.87), fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: darkGreen.withOpacity(0.87), fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: darkGreen.withOpacity(0.87)),
      bodyMedium: TextStyle(color: darkGreen.withOpacity(0.87)),
    ),
    iconTheme: IconThemeData(
      color: lightPrimary,
      size: 24,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: paleGreen,
      secondary: lightGreen,
      tertiary: mediumGreen,
      background: darkGreen,
      surface: green.withOpacity(0.8),
      onPrimary: darkGreen,
      onSecondary: darkGreen,
      onBackground: paleGreen,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkGreen,
      foregroundColor: paleGreen,
      elevation: 2,
      centerTitle: true,
      shadowColor: Colors.black.withOpacity(0.3),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: paleGreen,
      ),
    ),
    cardTheme: CardTheme(
      color: green.withOpacity(0.7),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightGreen,
        foregroundColor: darkGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: paleGreen, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: paleGreen, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: paleGreen, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: Colors.white.withOpacity(0.9)),
      bodyMedium: TextStyle(color: Colors.white.withOpacity(0.9)),
    ),
    iconTheme: IconThemeData(
      color: paleGreen,
      size: 24,
    ),
  );
} 