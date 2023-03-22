import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/health_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.low),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Health Statictics',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: AppPaddings.hight),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: AppPaddings.hight + AppPaddings.low,
                runSpacing: AppPaddings.hight,
                children: const [
                  HealthCard(
                    title: 'Шаги',
                    statistic: '25461 шаг',
                    color: HealthCardColors.step,
                  ),
                  HealthCard(
                    title: 'Активность',
                    statistic: '22 м. 56 с. ходьбы',
                    color: HealthCardColors.activity,
                  ),
                  HealthCard(
                    title: 'Расход энергии',
                    statistic: '1482 калорий потрачено',
                    color: HealthCardColors.energyConsumption,
                    isFullWidth: true,
                  ),
                ],
              ),
              const SizedBox(height: AppPaddings.low),
            ],
          ),
        ),
      ),
    );
  }
}
