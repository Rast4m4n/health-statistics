import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/domain/models/health_model.dart';
import 'package:health_statistics/domain/models/user_model.dart';

class PieChartViewModel {
  PieChartViewModel();

  final _repo = HealthStatisticsRepository(
    healthApi: HealthApi(),
    userApi: UserApi(),
  );

  int quantityWomen = 0;
  int quantityMen = 0;
  int totalQuantity = 0;

  int userOlderLow = 0;
  int userOlderMedium = 0;
  int userOlderHight = 0;
  int userOlderExtraHight = 0;

  int userWithSmallWalk = 0;
  int userWithMediumWalk = 0;
  int userWithHightWalk = 0;

  int userWithBadActivity = 0;
  int userWithGoodActivity = 0;

  /// процент людей, которых обошли по шагам.
  double percentMotivations = 0;

  Future<void> fetchDataFromDB() async {
    final healthData = await _repo.fetchHealthData();
    final usersData = await _repo.fetchUserData();

    for (var user in usersData) {
      _getCountUsersByGender(user);
      _getCountUsersByAge(user);
    }
    for (var health in healthData) {
      _getUserByLessActivity(health);
      _getUserByMinutesActivity(health);
    }
    totalQuantity = healthData.length;
    await _getMotivationsSteps();
  }

  void _getCountUsersByGender(UserModel user) {
    if (user.gender == GenderEnum.male.nameGender) {
      quantityMen += 1;
    } else if (user.gender == GenderEnum.female.nameGender) {
      quantityWomen += 1;
    }
  }

  void _getCountUsersByAge(UserModel user) {
    if (user.age < 18) {
      userOlderLow += 1;
    } else if (user.age >= 18 && user.age <= 30) {
      userOlderMedium += 1;
    } else if (user.age >= 30 && user.age <= 60) {
      userOlderHight += 1;
    } else if (user.age > 60) {
      userOlderExtraHight += 1;
    }
  }

  void _getUserByLessActivity(HealthModel health) {
    if (health.steps < 3000) {
      userWithSmallWalk += 1;
    } else if (health.steps >= 3000 && health.steps <= 10000) {
      userWithMediumWalk += 1;
    } else if (health.steps > 10000) {
      userWithHightWalk += 1;
    }
  }

  void _getUserByMinutesActivity(HealthModel health) {
    if (health.minutesWalk < 75) {
      userWithBadActivity += 1;
    } else {
      userWithGoodActivity += 1;
    }
  }

  /// получает процент людей, которых обогнал пользователь по количеству шагов.
  Future<void> _getMotivationsSteps() async {
    final healthData = await _repo.fetchHealthData();

    final currentUser = await SharedPrefRepository.instance.getUserData();
    final listUsersSteps = [];
    int mySteps = 0;
    for (var health in healthData) {
      if (currentUser!.id == health.userId) {
        mySteps = health.steps;
      } else {
        listUsersSteps.add(health.steps);
      }
    }

    listUsersSteps.add(mySteps);
    listUsersSteps.sort();
    final index = listUsersSteps.indexOf(mySteps);

    percentMotivations = index / (listUsersSteps.length - 1) * 100;
  }
}
