import 'package:flutter/material.dart';
import 'package:health_statistics/domain/models/theme_switcher.dart';

abstract class AppColors {
  // general
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Colors.grey;
  static const Color black = Color(0xff000000);
  static const Color bgDark = Color(0xff2A1B3D);

  static Color steps =
      ThemeSwitcher.isDark ? const Color(0xffD83F87) : const Color(0xffFF9292);
  static Color activity =
      ThemeSwitcher.isDark ? const Color(0xff44318D) : const Color(0xff92BDFF);
  static Color burnedEnergy =
      ThemeSwitcher.isDark ? const Color(0xff52929E) : const Color(0xffBF98FF);

  static Color tableBackground =
      ThemeSwitcher.isDark ? const Color(0xff4A536B) : const Color(0xffF6F6F6);
}
