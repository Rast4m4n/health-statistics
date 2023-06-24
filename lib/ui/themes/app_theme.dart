import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';
import 'package:health_statistics/ui/themes/app_text_style.dart';
import 'package:health_statistics/ui/themes/app_theme_ext.dart';

class AppTheme {
  static ThemeData ligth = ThemeData().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColorsCardExt.ligth(),
    ],
    textTheme: AppTextStyle.textStyleLightTheme,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: AppTextStyle.textStyleLightTheme.headlineMedium,
    ),
  );

  static ThemeData dark = ThemeData().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColorsCardExt.dark(),
    ],
    textTheme: AppTextStyle.textStyleDarkTheme,
    scaffoldBackgroundColor: AppColors.bgDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgDark,
      titleTextStyle: AppTextStyle.textStyleLightTheme.headlineMedium,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgDark,
      selectedIconTheme: IconThemeData(color: AppColors.white),
      unselectedIconTheme: IconThemeData(color: AppColors.grey),
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.grey,
    ),
  );
}
