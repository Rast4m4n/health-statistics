import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/domain/models/health_model.dart';

class PieChartViewModel {
  PieChartViewModel();

  int quantityWomen = 0;
  int quantityMen = 0;
  int totalQuantity = 0;

  Future<void> fetchDataFromDB() async {
    final repo = HealthStatisticsRepository(healthApi: HealthStatisticApi());
    final data = await repo.fetchHealthData();
    final emails = <String>[];
    getCountUsers(data, emails);
  }

  void getCountUsers(List<HealthModel> data, List<String> emails) {
    for (var health in data) {
      if (!emails.contains(health.email)) {
        emails.add(health.email!);
        if (health.gender == GenderEnum.male.nameGender) {
          quantityMen += 1;
        } else if (health.gender == GenderEnum.female.nameGender) {
          quantityWomen += 1;
        }
      }
    }
    totalQuantity = emails.length;
  }
}
