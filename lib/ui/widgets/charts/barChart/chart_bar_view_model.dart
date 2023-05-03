import 'dart:async';

import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/models/health_model.dart';

class ChartBarViewModel {
  ChartBarViewModel();

  final List<Bar> barData = [];
  final Map<int, HealthModel> _dayAndHealth = {};

  Future<List<Bar>> fetchDataFromDB() async {
    final healths = await SharedPrefRepository.instance.getHealthData();

    for (var health in healths) {
      _dayAndHealth[health.dateTimeActivity.weekday] = health;
    }
    for (var i = 1; i <= 7; i++) {
      if (_dayAndHealth[i] != null) {
        barData.add(
          Bar(
            xAxis: i,
            yAxisSteps: _dayAndHealth[i]!.steps.toDouble(),
            yAxisCalories: _dayAndHealth[i]!.burnedEnergy.toDouble(),
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
