import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/models/healthModel/health_model.dart';
import 'package:health_statistics/ui/widgets/charts/barChart/chart_bar_health_stat.dart';

class ChartBarViewModel {
  ChartBarViewModel(ChartsBarHealthStatState widget) : _widget = widget;

  final ChartsBarHealthStatState _widget;

  late AnimationController controller;

  void init() {
    controller = AnimationController(
      vsync: _widget,
      duration: const Duration(seconds: 1),
    );
    controller.forward();
  }

  void disposeController() => controller.dispose();

  Future<List<Bar>> fetchDataFromDB() async {
    final healths = await SharedPrefRepository.instance.getHealthData();
    final List<Bar> barData = [];
    final Map<int, HealthModel> dayAndHealth = {};

    for (var health in healths) {
      dayAndHealth[health.dateTimeActivity.weekday] = health;
    }
    for (var i = 1; i <= 7; i++) {
      if (dayAndHealth[i] != null) {
        barData.add(
          Bar(
            xAxis: i,
            yAxisSteps: dayAndHealth[i]!.steps.toDouble(),
            yAxisCalories: dayAndHealth[i]!.burnedEnergy.toDouble(),
          ),
        );
      } else {
        barData.add(
          Bar(
            xAxis: i,
            yAxisSteps: 0,
            yAxisCalories: 0,
          ),
        );
      }
    }
    return barData;
  }
}

class Bar {
  final int xAxis;
  final double yAxisSteps;
  final double? yAxisCalories;

  const Bar({
    required this.xAxis,
    required this.yAxisSteps,
    this.yAxisCalories,
  });
}
