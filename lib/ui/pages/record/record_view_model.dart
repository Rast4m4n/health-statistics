import 'package:flutter/material.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/domain/models/healthModel/health_model.dart';
import 'package:health_statistics/ui/widgets/recordCard/record_card.dart';

class RecordViewModel {
  const RecordViewModel({
    required HealthStatisticsRepository repo,
  }) : _repo = repo;

  final HealthStatisticsRepository _repo;

  Future<List<Widget>> recordBySteps() async {
    final healths = _quickSortBySteps(
      await _repo.healthApi.fetchHealthData(),
    );
    final users = await _repo.fetchUserData();

    final topUser = healths.take(5).toList();

    final currentUserEmail = (await AuthGoogle().getEmail())!;
    final currentUser = users.firstWhere(
      (element) => element.email == currentUserEmail,
    );

    final recordCards = <Widget>[];

    for (var health in topUser) {
      for (var user in users) {
        if (health.userId == user.id) {
          recordCards.add(
            RecordCard(
              top: topUser.indexWhere(
                    (element) => element.id == health.id,
                  ) +
                  1,
              email: user.email,
              age: user.age.toString(),
              steps: health.steps,
            ),
          );
        }
      }
    }

    for (var health in healths) {
      print(health.steps);
      if (health.userId == currentUser.id) {
        if (healths.indexOf(health) >= topUser.length) {
          recordCards.add(const Icon(Icons.more_horiz));
          recordCards.add(
            RecordCard(
              top: healths.indexWhere((el) => el.id == health.id),
              email: currentUser.email,
              age: currentUser.age.toString(),
              steps: health.steps,
            ),
          );
        }
      }
    }

    return recordCards;
  }

  List<HealthModel> _quickSortBySteps(
    List<HealthModel> healthData,
  ) {
    if (healthData.length <= 1) {
      return healthData;
    }

    int pivotIndex = (healthData.length / 2).floor();
    HealthModel pivot = healthData[pivotIndex];

    List<HealthModel> left = [];
    List<HealthModel> right = [];

    for (int i = 0; i < healthData.length; i++) {
      if (i == pivotIndex) continue;

      if (healthData[i].steps >= pivot.steps) {
        left.add(healthData[i]);
      } else {
        right.add(healthData[i]);
      }
    }

    return [
      ...(_quickSortBySteps(left)),
      pivot,
      ...(_quickSortBySteps(right)),
    ];
  }
}
