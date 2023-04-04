// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthStatisticModel _$HealthStatisticModelFromJson(
        Map<String, dynamic> json) =>
    HealthStatisticModel(
      email: json['email'] as String?,
      steps: json['steps'] as int,
      minutesWalk: json['minutesWalk'] as int,
      burnedEnergy: json['burnedEnergy'] as int,
      dateTimeActivity: DateTime.parse(json['dateTimeActivity'] as String),
    );

Map<String, dynamic> _$HealthStatisticModelToJson(
        HealthStatisticModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'steps': instance.steps,
      'minutesWalk': instance.minutesWalk,
      'burnedEnergy': instance.burnedEnergy,
      'dateTimeActivity': instance.dateTimeActivity.toIso8601String(),
    };
