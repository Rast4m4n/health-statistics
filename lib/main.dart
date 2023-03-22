import 'package:flutter/material.dart';
import 'package:health_statistics/app.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';

void main() {
  final navigation = AppNavigation();
  final theme = AppTheme();
  runApp(
    MainApp(
      navigation: navigation,
      theme: theme,
    ),
  );
}
