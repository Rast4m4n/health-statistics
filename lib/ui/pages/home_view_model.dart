import 'package:health/health.dart';

class HomeViewModel {
  HomeViewModel();

  List<HealthDataPoint> healthData = [];
  int steps = 0;
  int eneregyBurned = 0;
  final HealthFactory health = HealthFactory();

  final _types = [
    HealthDataType.STEPS,
    HealthDataType.MOVE_MINUTES,
    HealthDataType.WORKOUT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  final _permission = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];
  final _now = DateTime.now();

  // Получение общих данных о здоровье
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
        print("Ошибка $e");
      }
    } else {
      print('Нет доступа к типам данных');
    }

    getEnergyBurned();
    await getSteps();
  }

  // Получение сожжёных калорий
  void getEnergyBurned() {
    for (var el in healthData) {
      if (el.value is WorkoutHealthValue) {
        eneregyBurned = (el.value as WorkoutHealthValue).totalEnergyBurned ?? 0;
        print("Сожжено калорий - $eneregyBurned");
      }
    }
  }

  Future<void> getSteps() async {
    final midnight = DateTime(_now.year, _now.month, _now.day);
    try {
      steps = await health.getTotalStepsInInterval(midnight, _now) ?? 0;
    } catch (error) {
      print("Ошибка получение шагов: $error");
    }
  }
}
