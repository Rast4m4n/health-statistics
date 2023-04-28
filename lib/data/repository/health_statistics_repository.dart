import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/domain/models/health_model.dart';
import 'package:health_statistics/domain/models/user_model.dart';

class HealthStatisticsRepository {
  const HealthStatisticsRepository({
    required this.healthApi,
    required this.userApi,
  });

  final HealthApi healthApi;
  final UserApi userApi;

  // HealthModel
  Future<List<HealthModel>> fetchHealthData() => healthApi.fetchHealthData();

  Future<void> saveHealthData(HealthModel healthData) =>
      healthApi.saveHealthData(healthData);

  // UserModel
  Future<List<UserModel>> fetchUserData() => userApi.fetchUserData();

  Future<void> saveUserData(UserModel userData) =>
      userApi.saveUserData(userData);
}
