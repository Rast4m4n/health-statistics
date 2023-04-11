import 'package:flutter/material.dart';

import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/ui/pages/home/home_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/chart_health_stat.dart';
import 'package:health_statistics/ui/widgets/healthCard/health_card.dart';

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
                        color: AppColors.step,
                      ),
                      HealthCard(
                        title: 'Активность',
                        statistic: '${vm.moveMinutes} минут',
                        color: AppColors.activity,
                      ),
                      HealthCard(
                        title: 'Расход энергии',
                        statistic: '${vm.eneregyBurned} калорий потрачено',
                        color: AppColors.energyConsumption,
                        isFullWidth: true,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppPaddings.hight * 2),
              const ChartsHealthStat(),
            ],
          ),
        ),
      ),
    );
  }
}
