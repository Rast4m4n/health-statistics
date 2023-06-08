import 'package:flutter/material.dart';

class AppTextStyle {
  // Light Theme
  static TextTheme textStyleLightTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      // fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 22,
      // fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
  );
  // Dark Theme
  static TextTheme textStyleDarkTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      // fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 22,
      // fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  );
}
