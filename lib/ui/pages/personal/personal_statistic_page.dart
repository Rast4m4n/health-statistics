import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/domain/enums/pie_chart_enum.dart';
import 'package:health_statistics/domain/models/theme_switcher.dart';
import 'package:health_statistics/ui/pages/personal/personal_statistic_view_model.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/widgets/charts/barChart/chart_bar_health_stat.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_widget.dart';
import 'package:health_statistics/ui/widgets/healthCard/health_card.dart';

class PersonalStatisticPage extends StatelessWidget {
  PersonalStatisticPage({
    super.key,
  });
  final _healthRepository = const HealthStatisticsRepository(
    healthApi: HealthApi(),
    userApi: UserApi(),
  );

  late final vm = PersonalViewModel(
    healthRepository: _healthRepository,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.low),
      child: ListView(
        children: [
          const SizedBox(height: AppPaddings.hight),
          _HealthCards(vm: vm),
          const SizedBox(height: AppPaddings.hight),
          const _MotivationChart(),
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
      ),
    );
  }
}

class _HealthCards extends StatelessWidget {
  const _HealthCards({
    super.key,
    required this.vm,
  });

  final PersonalViewModel vm;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                color: AppColors.steps),
            HealthCard(
                title: 'Активность',
                statistic: '${vm.moveMinutes} минут',
                color: AppColors.activity),
            HealthCard(
              title: 'Расход энергии',
              statistic: '${vm.eneregyBurned} калорий потрачено',
              color: AppColors.burnedEnergy,
              isFullWidth: true,
            ),
          ],
        );
      },
    );
  }
}

class _MotivationChart extends StatelessWidget {
  const _MotivationChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PieChartWidget(
          statText: [
            TextStatistic(
              text: 'Вы обошли по шагам\n пользователей',
              color: AppColors.steps,
            ),
            TextStatistic(
              text: 'Вас обошли по шагам\n пользователей',
              color: AppColors.activity,
            ),
          ],
          pieColor: [
            AppColors.steps,
            AppColors.activity,
          ],
          typeChart: PieChartEnum.percentMotivations,
        ),
      ],
    );
  }
}
