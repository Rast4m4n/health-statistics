import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/domain/models/health_model.dart';

class HealthStatisticsRepository {
  const HealthStatisticsRepository({required this.healthApi});
  final HealthStatisticApi healthApi;

  Future<List<HealthModel>> fetchHealthData() => healthApi.fetchHealth();

  Future<void> saveHealthData(HealthModel healthData) =>
      healthApi.saveHealthData(healthData);
}
