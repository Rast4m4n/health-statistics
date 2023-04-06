import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';
import 'package:health_statistics/ui/pages/home_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/health_card.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final _healthRepository = HealthStatisticsRepository(
    healthApi: HealthStatisticApi(),
  );

  late final vm = HomeViewModel(
    healthRepository: _healthRepository,
  );

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
                future: vm.fetchDataFromGoogleFit(),
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
