import 'package:flutter/material.dart';
import 'package:health_statistics/ui/pages/home_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/health_card.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final vm = HomeViewModel();
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
              FutureBuilder(
                future: vm.fetchDataHealth(),
                builder: (context, snapshot) {
                  return Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: AppPaddings.hight + AppPaddings.low,
                    runSpacing: AppPaddings.hight,
                    children: [
                      HealthCard(
                        title: 'Шаги',
                        statistic: '${vm.steps} шагов',
                        color: HealthCardColors.step,
                      ),
                      HealthCard(
                        title: 'Активность',
                        statistic: '${vm.moveMinutes} минут',
                        color: HealthCardColors.activity,
                      ),
                      HealthCard(
                        title: 'Расход энергии',
                        statistic: '${vm.eneregyBurned} калорий потрачено',
                        color: HealthCardColors.energyConsumption,
                        isFullWidth: true,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppPaddings.low),
            ],
          ),
        ),
      ),
    );
  }
}
