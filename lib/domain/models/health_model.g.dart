// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthModel _$HealthModelFromJson(Map<String, dynamic> json) => HealthModel(
      id: json['id'] as int,
      steps: json['steps'] as int,
      minutesWalk: json['minutesWalk'] as int,
      burnedEnergy: json['burnedEnergy'] as int,
      dateTimeActivity: DateTime.parse(json['dateTimeActivity'] as String),
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$HealthModelToJson(HealthModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'steps': instance.steps,
      'minutesWalk': instance.minutesWalk,
      'burnedEnergy': instance.burnedEnergy,
      'dateTimeActivity': instance.dateTimeActivity.toIso8601String(),
      'userId': instance.userId,
    };
