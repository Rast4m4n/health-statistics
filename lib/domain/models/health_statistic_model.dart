import 'package:json_annotation/json_annotation.dart';

part 'health_statistic_model.g.dart';

@JsonSerializable()
class HealthStatisticModel {
  final String? email;
  final int steps;
  final int minutesWalk;
  final int burnedEnergy;
  final DateTime dateTimeActivity;

  const HealthStatisticModel({
    required this.email,
    required this.steps,
    required this.minutesWalk,
    required this.burnedEnergy,
    required this.dateTimeActivity,
  });

  factory HealthStatisticModel.fromJson(Map<String, dynamic> json) =>
      _$HealthStatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthStatisticModelToJson(this);
}
