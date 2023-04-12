// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthModel _$HealthModelFromJson(Map<String, dynamic> json) => HealthModel(
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      steps: json['steps'] as int,
      minutesWalk: json['minutesWalk'] as int,
      burnedEnergy: json['burnedEnergy'] as int,
      dateTimeActivity: DateTime.parse(json['dateTimeActivity'] as String),
    );

Map<String, dynamic> _$HealthModelToJson(HealthModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'steps': instance.steps,
      'minutesWalk': instance.minutesWalk,
      'burnedEnergy': instance.burnedEnergy,
      'dateTimeActivity': instance.dateTimeActivity.toIso8601String(),
    };
