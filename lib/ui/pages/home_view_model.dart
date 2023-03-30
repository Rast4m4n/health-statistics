import 'package:health/health.dart';

class HomeViewModel {
  HomeViewModel();

  List<HealthDataPoint> healthData = [];
  int steps = 0;
  int eneregyBurned = 0;
  int moveMinutes = 0;
  final HealthFactory health = HealthFactory();

  final _types = [
    HealthDataType.STEPS,
    HealthDataType.MOVE_MINUTES,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  final _permission = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];
  final _now = DateTime.now();

  Future<void> fetchDataHealth() async {
    bool requested = await health.requestAuthorization(
      _types,
      permissions: _permission,
    );

    final midnight = DateTime(_now.year, _now.month, _now.day);

    if (requested) {
      try {
        healthData =
            await health.getHealthDataFromTypes(midnight, _now, _types);
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Нет доступа к данным');
    }

    eneregyBurned = getHealthData(HealthDataType.ACTIVE_ENERGY_BURNED);
    moveMinutes = getHealthData(HealthDataType.MOVE_MINUTES);
    await getSteps();
  }

  int getHealthData(HealthDataType dataType) {
    int health = 0;
    for (var el in healthData) {
      if (el.typeString == dataType.name) {
        if (el.value is NumericHealthValue) {
          health += (el.value as NumericHealthValue).numericValue.round();
        }
      }
    }
    return health;
  }

  Future<void> getSteps() async {
    final midnight = DateTime(_now.year, _now.month, _now.day);
    try {
      steps = await health.getTotalStepsInInterval(midnight, _now) ?? 0;
    } catch (error) {
      throw Exception(error);
    }
  }
}
