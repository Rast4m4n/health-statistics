import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';

class HealthStatisticsRepository {
  const HealthStatisticsRepository({required this.healthApi});
  final HealthStatisticApi healthApi;

  Future<List<HealthStatisticModel>> fetchHealthData() =>
      healthApi.fetchHealth();

  Future<void> saveHealthData(HealthStatisticModel healthData) =>
      healthApi.saveHealthData(healthData);
}
