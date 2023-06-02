import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color coral = Color(0xffFF9292);
  static const Color skyBlue = Color(0xff92BDFF);
  static const Color purple = Color(0xffBF98FF);
  static const Color green = Color.fromARGB(255, 118, 255, 116);
  static const Color grey = Color(0xffF6F6F6);
  static const Color white = Color(0xffFFFFFF);
}

class AppTheme {
  final ThemeData theme = ThemeData().copyWith(
    textTheme: const TextTheme(
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
    ),
  );
}
