import 'package:flutter/material.dart';

abstract class HealthCardColors {
  static const Color step = Color(0xffFF9292);
  static const Color activity = Color(0xff92BDFF);
  static const Color energyConsumption = Color(0xffBF98FF);
}

class AppTheme {
  final ThemeData theme = ThemeData().copyWith(
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
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
    ),
  );
}
