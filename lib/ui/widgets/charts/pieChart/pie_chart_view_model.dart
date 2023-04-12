import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/domain/models/health_model.dart';

class PieChartViewModel {
  PieChartViewModel();

  int quantityWomen = 0;
  int quantityMen = 0;
  int totalQuantity = 0;

  int userOlderLow = 0;
  int userOlderMedium = 0;
  int userOlderHight = 0;

  int userWithSmallWalk = 0;
  int userWithMediumWalk = 0;
  int userWithHightWalk = 0;

  final _emails = <String>[];

  Future<void> fetchDataFromDB() async {
    final repo = HealthStatisticsRepository(healthApi: HealthStatisticApi());
    final data = await repo.fetchHealthData();
    data.sort(
      (a, b) => a.dateTimeActivity.compareTo(b.dateTimeActivity),
    );
    final sortedData = data;
    for (var health in sortedData) {
      if (!_emails.contains(health.email)) {
        _emails.add(health.email!);
        _getCountUsersByGender(health);
        _getCountUsersByAge(health);
        _getUserByLessActivity(health);
      }
    }
    totalQuantity = _emails.length;
  }

  void _getCountUsersByGender(HealthModel health) {
    if (health.gender == GenderEnum.male.nameGender) {
      quantityMen += 1;
    } else if (health.gender == GenderEnum.female.nameGender) {
      quantityWomen += 1;
    }
  }

  void _getCountUsersByAge(HealthModel health) {
    if (health.age! < 18) {
      userOlderLow += 1;
    } else if (health.age! >= 18 && health.age! <= 40) {
      userOlderMedium += 1;
    } else if (health.age! >= 40) {
      userOlderHight += 1;
    }
  }

  void _getUserByLessActivity(HealthModel health) {
    if (health.steps < 5000) {
      userWithSmallWalk += 1;
    } else if (health.steps >= 5000 && health.steps < 15000) {
      userWithMediumWalk += 1;
    } else if (health.steps >= 15000 && health.steps < 25000) {
      userWithHightWalk += 1;
    }
  }
}
