import 'package:flutter/material.dart';

class AppTheme {
  // Dark background colors
  static const Color darkBackground = Color(0xFF2C1A1A); // Very dark brown
  static const Color darkMaroon = Color(0xFF4A1C1C); // Dark maroon for headers/bubbles
  static const Color darkNavy = Color(0xFF1A1A2E); // Dark navy for some screens
  
  // Accent colors
  static const Color brightRed = Color(0xFFE53935); // Bright red for buttons
  static const Color lightRed = Color(0xFFB71C1C); // Lighter red for secondary buttons
  
  // Text colors
  static const Color whiteText = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color mediumGray = Color(0xFF999999);
  
  // Card colors
  static const Color cardBackground = Color(0xFFF5F5DC); // Beige for library cards
  static const Color darkCard = Color(0xFF3A2A2A); // Dark card background
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: brightRed,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: brightRed,
        secondary: lightRed,
        surface: darkMaroon,
        background: darkBackground,
        onPrimary: whiteText,
        onSecondary: whiteText,
        onSurface: whiteText,
        onBackground: whiteText,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: whiteText, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: whiteText, fontSize: 24, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: whiteText, fontSize: 20, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: whiteText, fontSize: 18, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: whiteText, fontSize: 16),
        bodyMedium: TextStyle(color: whiteText, fontSize: 14),
        bodySmall: TextStyle(color: lightGray, fontSize: 12),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkMaroon,
        foregroundColor: whiteText,
        elevation: 0,
      ),
    );
  }
}

