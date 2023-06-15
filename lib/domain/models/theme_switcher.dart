import 'package:flutter/material.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';

class ThemeSwitcher with ChangeNotifier {
  static ThemeSwitcher? _singleTon;
  static ThemeSwitcher get instance => _singleTon!;

  ThemeSwitcher._internal();

  factory ThemeSwitcher() {
    _singleTon ??= ThemeSwitcher._internal();
    return instance;
  }

  static bool isDark = false;

  ThemeData currentTheme() => isDark ? AppTheme.dark : AppTheme.ligth;

  void switchTheme() =>
      SharedPrefRepository.instance.saveThemeData(isDark = !isDark).then(
            (value) => notifyListeners(),
          );
}
