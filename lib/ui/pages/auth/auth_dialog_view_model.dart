import 'package:flutter/material.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/ui/navigations/app_navigation.dart';

class AuthDialogVIewModel {
  final TextEditingController textAge;
  GenderEnum? gender;

  AuthDialogVIewModel({required this.textAge, required this.gender});

  Future<void> saveData(BuildContext context) async {
    await SharedPrefRepository.instance.saveUserData(
      gender!.nameGender,
      int.parse(textAge.text),
    );
    if (context.mounted) Navigator.of(context).pushNamed(AppRoute.home);
  }
}
