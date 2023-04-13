import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_statistics_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/ui/pages/personal/personal_statistic_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/barChart/chart_health_stat.dart';
import 'package:health_statistics/ui/widgets/healthCard/health_card.dart';

class PersonalStatisticPage extends StatelessWidget {
  PersonalStatisticPage({
    super.key,
  });
  final _healthRepository = HealthStatisticsRepository(
    healthApi: HealthStatisticApi(),
  );

  late final vm = PersonalViewModel(
    healthRepository: _healthRepository,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.low),
          child: _Statistics(vm: vm),
        ),
      ),
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics({
    super.key,
    required this.vm,
  });

  final PersonalViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Статистика активности',
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
                  color: AppColors.coral,
                ),
                HealthCard(
                  title: 'Активность',
                  statistic: '${vm.moveMinutes} минут',
                  color: AppColors.skyBlue,
                ),
                HealthCard(
                  title: 'Расход энергии',
                  statistic: '${vm.eneregyBurned} калорий потрачено',
                  color: AppColors.purple,
                  isFullWidth: true,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppPaddings.hight * 2),
        const ChartsHealthStat(),
      ],
    );
  }
}
