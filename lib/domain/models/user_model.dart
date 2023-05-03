import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  final String gender;
  final int age;

  const UserModel({
    required this.id,
    required this.email,
    required this.gender,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  bool operator ==(other) {
    return (other is UserModel) &&
        other.id == id &&
        other.email == email &&
        other.gender == gender &&
        other.age == age;
  }

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ gender.hashCode ^ age.hashCode;
}
