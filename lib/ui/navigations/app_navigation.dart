import 'package:flutter/material.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/ui/pages/auth/auth_dialog.dart';
import 'package:health_statistics/ui/pages/home_page.dart';

class AppRoute {
  static String home = '/';
  static String auth = '/auth';
}

class AppNavigation {
  bool _isAuth = false;

  Future<void> auth() async {
    final user = await SharedPrefRepository.instance.getUserData();
    if (user == null) {
      _isAuth = false;
    } else {
      _isAuth = true;
    }
  }

  String get initialRoute => _isAuth ? AppRoute.home : AppRoute.auth;

  Map<String, Widget Function(BuildContext)> get routes => {
        AppRoute.home: (context) => const HomePage(),
        AppRoute.auth: (context) => const AuthDialog(),
      };
}
