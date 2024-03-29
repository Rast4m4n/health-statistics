import 'package:health/health.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/domain/models/healthModel/health_model.dart';
import 'package:health_statistics/domain/models/userModel/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonalViewModel {
  PersonalViewModel({
    required this.healthRepository,
  });
  final HealthStatisticsRepository healthRepository;
  List<HealthDataPoint> _healthData = [];
  final _googleUser = AuthGoogle();

  int _steps = 0;
  int get steps => _steps;

  int? _eneregyBurned;
  int? get eneregyBurned => _eneregyBurned;

  int _moveMinutes = 0;
  int get moveMinutes => _moveMinutes;

  int _distanceMove = 0;
  int get distanceMove => _distanceMove;

  final HealthFactory _health = HealthFactory();

  final _types = const [
    HealthDataType.STEPS,
    HealthDataType.MOVE_MINUTES,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_DELTA,
  ];

  final _permission = const [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  final _now = DateTime.now();

  Future<void>? fetchDataFuture;

  void init() {
    checkAndRequestStatusPermission();
    fetchDataFuture = fetchDataFromGoogleFit();
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

    _distanceMove = _getHealthData(HealthDataType.DISTANCE_DELTA);

    await _getSteps();

    await _saveToDB();
    await _saveToShared();
  }

  Future<void> checkAndRequestStatusPermission() async {
    var statusActivity = await Permission.activityRecognition.status;
    var statusLocation = await Permission.location.status;

    if (statusActivity.isDenied || statusLocation.isDenied) {
      await Permission.activityRecognition.request();
      await Permission.location.request();
    }
  }

  Future<void> _saveToDB() async {
    final user = (await SharedPrefRepository.instance.getUserData())!;

    final UserModel userModel = UserModel(
      id: user.id,
      email: (await _googleUser.getEmail())!,
      gender: user.gender,
      age: user.age,
    );

    await healthRepository.saveUserData(userModel);

    int healthId = 1;

    final health = await healthRepository.fetchHealthData();

    for (var health in health) {
      if (health.userId == user.id) {
        healthId = health.id;
      }
    }

    await healthRepository.saveHealthData(
      HealthModel(
        id: healthId,
        steps: steps,
        minutesWalk: _moveMinutes,
        burnedEnergy: _eneregyBurned!,
        dateTimeActivity: DateTime.now(),
        userId: userModel.id,
      ),
    );
  }

  Future<void> _saveToShared() async {
    final user = (await SharedPrefRepository.instance.getUserData())!;
    final UserModel userModel = UserModel(
      id: user.id,
      email: (await _googleUser.getEmail())!,
      gender: user.gender,
      age: user.age,
    );
    final healths = await healthRepository.fetchHealthData();
    for (var health in healths) {
      if (health.userId == userModel.id) {
        await SharedPrefRepository.instance.saveHealthData(health);
      }
    }
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
