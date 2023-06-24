import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';

class AppColorsCardExt extends ThemeExtension<AppColorsCardExt> {
  final Color? stepColor;
  final Color? activityColor;
  final Color? burnedEnergyColor;
  final Color? tableBackgroundColor;

  AppColorsCardExt({
    required this.stepColor,
    required this.activityColor,
    required this.burnedEnergyColor,
    required this.tableBackgroundColor,
  });

  factory AppColorsCardExt.ligth() {
    return AppColorsCardExt(
      stepColor: AppColors.stepsLight,
      activityColor: AppColors.activityLight,
      burnedEnergyColor: AppColors.burnedEnergyLight,
      tableBackgroundColor: AppColors.tableBackgroundLight,
    );
  }

  factory AppColorsCardExt.dark() {
    return AppColorsCardExt(
      stepColor: AppColors.stepsDark,
      activityColor: AppColors.activityDark,
      burnedEnergyColor: AppColors.burnedEnergyDark,
      tableBackgroundColor: AppColors.tableBackgroundDark,
    );
  }

  @override
  ThemeExtension<AppColorsCardExt> copyWith({
    Color? stepColor,
    Color? activityColor,
    Color? burnedEnergyColor,
    Color? tableBackgroundColor,
  }) {
    return AppColorsCardExt(
      stepColor: stepColor ?? this.stepColor,
      activityColor: activityColor ?? this.activityColor,
      burnedEnergyColor: burnedEnergyColor ?? this.burnedEnergyColor,
      tableBackgroundColor: tableBackgroundColor ?? this.tableBackgroundColor,
    );
  }

  @override
  ThemeExtension<AppColorsCardExt> lerp(AppColorsCardExt? other, double t) {
    if (other is! AppColorsCardExt) {
      return this;
    }
    return AppColorsCardExt(
      stepColor: Color.lerp(
        stepColor,
        other.stepColor,
        t,
      ),
      activityColor: Color.lerp(
        activityColor,
        other.activityColor,
        t,
      ),
      burnedEnergyColor: Color.lerp(
        burnedEnergyColor,
        other.burnedEnergyColor,
        t,
      ),
      tableBackgroundColor: Color.lerp(
        tableBackgroundColor,
        other.tableBackgroundColor,
        t,
      ),
    );
  }
}
