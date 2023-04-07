import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';

class ChartBarViewModel {
  ChartBarViewModel();

  final List<Bar> barData = [];
  final Map<int, HealthStatisticModel> _dayAndHealth = {};

  Future<List<Bar>> fetchDataFromDB() async {
    final repo = HealthStatisticsRepository(healthApi: HealthStatisticApi());
    final user = AuthGoogle();
    final data = await repo.fetchHealthData();

    List<HealthStatisticModel> currentUserHeatlh = [];

    for (var health in data) {
      if (health.email == await user.getEmail()) {
        currentUserHeatlh.add(health);
      }
    }
    currentUserHeatlh.sort(
      (a, b) => a.dateTimeActivity.compareTo(b.dateTimeActivity),
    );

    for (var health in currentUserHeatlh) {
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
