import 'package:health/health.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';

class HomeViewModel {
  HomeViewModel({
    required this.healthRepository,
  });

  final HealthStatisticsRepository healthRepository;
  late HealthStatisticModel healthModel;
  List<HealthDataPoint> _healthData = [];
  final googleUser = AuthGoogle();

  int _steps = 0;
  int get steps => _steps;

  int _eneregyBurned = 0;
  int get eneregyBurned => _eneregyBurned;

  int _moveMinutes = 0;
  int get moveMinutes => _moveMinutes;

  final HealthFactory _health = HealthFactory();

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

  Future<void> fetchDataFromDB() async {
    final data = await healthRepository.fetchHealthData();
    List<DateTime> dates = [];

    for (var health in data) {
      if (health.email == await googleUser.getEmail()) {
        dates.add(health.dateTimeActivity);
        DateTime latestDate = dates.reduce(
          (value, element) => value.isAfter(element) ? value : element,
        );

        if (health.dateTimeActivity == latestDate) {
          healthModel = HealthStatisticModel(
            email: health.email,
            steps: health.steps,
            minutesWalk: health.minutesWalk,
            burnedEnergy: health.burnedEnergy,
            dateTimeActivity: health.dateTimeActivity,
          );
        }
      }
    }
  }

  Future<void> fetchDataFromGoogleFit() async {
    bool requested = await _health.requestAuthorization(
      _types,
      permissions: _permission,
    );

    final midnight = DateTime(_now.year, _now.month, _now.day);

    if (requested) {
      try {
        _healthData =
            await _health.getHealthDataFromTypes(midnight, _now, _types);
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Нет доступа к данным');
    }

    _eneregyBurned = _getHealthData(HealthDataType.ACTIVE_ENERGY_BURNED);
    _moveMinutes = _getHealthData(HealthDataType.MOVE_MINUTES);
    await _getSteps();

    await healthRepository.saveHealthData(
      HealthStatisticModel(
        email: await googleUser.getEmail(),
        steps: steps,
        minutesWalk: _moveMinutes,
        burnedEnergy: _eneregyBurned,
        dateTimeActivity: DateTime.now(),
      ),
    );
  }

  int _getHealthData(HealthDataType dataType) {
    int health = 0;
    for (var el in _healthData) {
      if (el.typeString == dataType.name) {
        if (el.value is NumericHealthValue) {
          health += (el.value as NumericHealthValue).numericValue.round();
        }
      }
    }
    return health;
  }

  Future<void> _getSteps() async {
    final midnight = DateTime(_now.year, _now.month, _now.day);
    try {
      _steps = await _health.getTotalStepsInInterval(midnight, _now) ?? 0;
    } catch (error) {
      throw Exception(error);
    }
  }
}
