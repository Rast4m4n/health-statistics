import 'package:flutter/material.dart';
import 'package:health_statistics/domain/enums/gender_enum.dart';
import 'package:health_statistics/ui/pages/auth/auth_dialog_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  GenderEnum? gender = GenderEnum.male;

  @override
  Widget build(BuildContext context) {
    final viewModel = AuthDialogVIewModel(
      textAge: TextEditingController(),
      gender: gender,
    );
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.low),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Пол: '),
            Row(
              children: [
                const Text('Муж'),
                Radio<GenderEnum>(
                  value: GenderEnum.male,
                  groupValue: gender,
                  onChanged: (GenderEnum? value) {
                    setState(
                      () {
                        gender = value;
                      },
                    );
                  },
                ),
                const Text('Жен'),
                Radio<GenderEnum>(
                  value: GenderEnum.female,
                  groupValue: gender,
                  onChanged: (GenderEnum? value) {
                    setState(() {
                      gender = GenderEnum.female;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppPaddings.low),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100),
              child: TextField(
                style: textStyle,
                controller: viewModel.textAge,
                decoration: InputDecoration(
                  label:
                      Text('Возраст', style: textStyle?.copyWith(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: AppPaddings.low),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => viewModel.saveData(context),
                  child: const Text('Сохранить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
