import 'package:flutter/material.dart';
import 'package:health_statistics/ui/pages/home/home_page.dart';

class AppRoute {
  static String home = '/';
}

class AppNavigation {
  String get initialRoute => AppRoute.home;

  Map<String, Widget Function(BuildContext)> get routes => {
        AppRoute.home: (context) => HomePage(),
      };
}
