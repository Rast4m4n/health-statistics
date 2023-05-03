import 'package:flutter/material.dart';
import 'package:health_statistics/app.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = AuthGoogle();
  await user.signIn();
  SharedPrefRepository();
  await SharedPrefRepository.instance.clearOldHealthData();
  // (await SharedPrefRepository.instance.prefs).clear();

  var statusActivity = await Permission.activityRecognition.status;
  var statusLocation = await Permission.location.status;

  if (statusActivity.isDenied || statusLocation.isDenied) {
    await Permission.activityRecognition.request();
    await Permission.location.request();
  }

  final navigation = AppNavigation();
  final theme = AppTheme();
  await navigation.auth();

  runApp(
    MainApp(
      navigation: navigation,
      theme: theme,
    ),
  );
}
