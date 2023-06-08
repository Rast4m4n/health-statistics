import 'package:json_annotation/json_annotation.dart';

part 'health_model.g.dart';

@JsonSerializable()
class HealthModel {
  final int id;
  final int steps;
  final int minutesWalk;
  final int burnedEnergy;
  final DateTime dateTimeActivity;
  final int userId;

  const HealthModel({
    required this.id,
    required this.steps,
    required this.minutesWalk,
    required this.burnedEnergy,
    required this.dateTimeActivity,
    required this.userId,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) =>
      _$HealthModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthModelToJson(this);

  HealthModel copyWith({
    required int? id,
    required int? steps,
    required int? minutesWalk,
    required int? burnedEnergy,
    required DateTime? dateTimeActivity,
    required int? userId,
  }) {
    return HealthModel(
      id: id ?? this.id,
      steps: steps ?? this.steps,
      minutesWalk: minutesWalk ?? this.minutesWalk,
      burnedEnergy: burnedEnergy ?? this.burnedEnergy,
      dateTimeActivity: dateTimeActivity ?? this.dateTimeActivity,
      userId: userId ?? this.userId,
    );
  }
}
