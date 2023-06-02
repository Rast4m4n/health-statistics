import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    super.key,
    required this.top,
    required this.email,
    required this.age,
    required this.steps,
  });
  final int top;
  final String email;
  final String age;
  final int steps;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.low,
        vertical: AppPaddings.medium,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.low,
            vertical: AppPaddings.medium,
          ),
          child: Row(
            children: [
              Text(
                '$top.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: AppPaddings.low),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$email $age лет',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppPaddings.medium),
                  Text(
                    '$steps шагов',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.coral),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
