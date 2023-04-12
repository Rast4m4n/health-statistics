import 'package:json_annotation/json_annotation.dart';

part 'health_model.g.dart';

@JsonSerializable()
class HealthModel {
  final String? email;
  final String? gender;
  final int? age;
  final int steps;
  final int minutesWalk;
  final int burnedEnergy;
  final DateTime dateTimeActivity;

  const HealthModel({
    required this.email,
    required this.gender,
    required this.age,
    required this.steps,
    required this.minutesWalk,
    required this.burnedEnergy,
    required this.dateTimeActivity,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) =>
      _$HealthModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthModelToJson(this);

  HealthModel copyWith({
    required String? email,
    required String? gender,
    required int? age,
    required int? steps,
    required int? minutesWalk,
    required int? burnedEnergy,
    required DateTime? dateTimeActivity,
  }) {
    return HealthModel(
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      steps: steps ?? this.steps,
      minutesWalk: minutesWalk ?? this.minutesWalk,
      burnedEnergy: burnedEnergy ?? this.burnedEnergy,
      dateTimeActivity: dateTimeActivity ?? this.dateTimeActivity,
    );
  }
}
