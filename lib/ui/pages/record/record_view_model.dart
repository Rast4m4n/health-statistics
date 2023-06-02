import 'package:flutter/material.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/models/health_model.dart';
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

    final recordCards = <Widget>[];

    for (var health in healths) {
      for (var user in users) {
        if (health.userId == user.id) {
          if (recordCards.length != 5) {
            recordCards.add(
              RecordCard(
                top: healths.indexWhere(
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
