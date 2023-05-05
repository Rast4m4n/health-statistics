import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/enums/pie_chart_enum.dart';
import 'package:health_statistics/ui/pages/personal/personal_statistic_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/barChart/chart_bar_health_stat.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_widget.dart';
import 'package:health_statistics/ui/widgets/healthCard/health_card.dart';

class PersonalStatisticPage extends StatelessWidget {
  PersonalStatisticPage({
    super.key,
  });
  final _healthRepository = HealthStatisticsRepository(
    healthApi: HealthApi(),
    userApi: UserApi(),
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
    return ListView(
      children: [
        Center(
          child: Text(
            'Статистика активности',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
                  statistic: '${vm.steps} шагов\n${vm.distanceMove}м. пройдено',
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
        const SizedBox(height: AppPaddings.hight),
        Column(
          children: [
            PieChartWidget(
              statText: const [
                TextStatistic(
                  text: 'Вы обошли по шагам\n пользователей',
                  color: AppColors.coral,
                ),
                TextStatistic(
                  text: 'Вас обошли по шагам\n пользователей',
                  color: AppColors.skyBlue,
                ),
              ],
              pieColor: const [AppColors.coral, AppColors.skyBlue],
              typeChart: PieChartEnum.percentMotivations,
            ),
          ],
        ),
        const SizedBox(height: AppPaddings.hight),
        Center(
          child: Text(
            'График активности за неделю',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: AppPaddings.hight * 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: const ChartsBarHealthStat(),
        ),
      ],
    );
  }
}
