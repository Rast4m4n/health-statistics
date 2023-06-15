import 'package:flutter/material.dart';
import 'package:health_statistics/domain/models/theme_switcher.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';

class App extends StatefulWidget {
  const App({super.key, required this.navigation});
  final AppNavigation navigation;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    ThemeSwitcher.instance.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Статистика активности',
      theme: ThemeSwitcher.instance.currentTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: widget.navigation.initialRoute,
      routes: widget.navigation.routes,
    );
  }
}
