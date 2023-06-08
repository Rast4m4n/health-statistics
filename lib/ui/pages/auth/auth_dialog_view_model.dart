import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/auth.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/domain/models/userModel/user_model.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';

class AuthDialogVIewModel {
  final TextEditingController textAge;
  final GenderEnum? gender;

  const AuthDialogVIewModel({required this.textAge, required this.gender});

  Future<void> saveData(BuildContext context) async {
    final accountGoogle = AuthGoogle();
    const repo = HealthStatisticsRepository(
      healthApi: HealthApi(),
      userApi: UserApi(),
    );
    final users = await repo.fetchUserData();

    await SharedPrefRepository.instance.saveUserData(
      UserModel(
        id: users.isNotEmpty ? users.last.id + 1 : 1,
        email: (await accountGoogle.getEmail())!,
        gender: gender!.nameGender,
        age: int.parse(textAge.text),
      ),
    );
    if (context.mounted) Navigator.of(context).pushNamed(AppRoute.home);
  }
}
