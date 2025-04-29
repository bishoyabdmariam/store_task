import 'package:flutter/material.dart';

class AppThemeStyle {
  // Light theme
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF7FBFC),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF007D99), // Blue-Green
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD1ECF1),
      onPrimaryContainer: Colors.black,
      secondary: Color(0xFF72C1A2), // Soft Green
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE0F5EC),
      onSecondaryContainer: Colors.black,
      error: Color(0xFFE74C3C), // Red
      onError: Colors.white,
      errorContainer: Color(0xFFFCE8E6),
      onErrorContainer: Colors.black,
      surface: Color(0xFFFFFFFF),
      onSurface: Colors.black,
      surfaceContainerHighest: Color(0xFFEEEEEE),
      outline: Color(0xFFCCCCCC),
      outlineVariant: Color(0xFFBDBDBD),
      shadow: Colors.black26,
      surfaceTint: Color(0xFF007D99),
      inverseSurface: Color(0xFF2C3E50),
      inversePrimary: Color(0xFF005F73),
    ),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF00A7BF), // Lighter Blue-Green for dark
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF004D5A),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xFF4CAF8F), // Slightly muted Soft Green
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF1D3D34),
      onSecondaryContainer: Colors.white,
      error: Color(0xFFCF6679), // Material dark error red
      onError: Colors.black,
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      surfaceContainerHighest: Color(0xFF2C2C2C),
      outline: Color(0xFF888888),
      outlineVariant: Color(0xFF666666),
      shadow: Colors.black45,
      surfaceTint: Color(0xFF00A7BF),
      inverseSurface: Color(0xFFE0E0E0),
      inversePrimary: Color(0xFF7FD4E3),
    ),
  );
}
