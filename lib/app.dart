import 'package:flutter/material.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.navigation, required this.theme});
  final AppNavigation navigation;
  final AppTheme theme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: navigation.initialRoute,
      routes: navigation.routes,
    );
  }
}
