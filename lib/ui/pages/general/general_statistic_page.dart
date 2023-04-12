import 'package:flutter/material.dart';
import 'package:health_statistics/domain/enums/pie_chart_enum.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_widget.dart';

class GeneralStatisticPage extends StatelessWidget {
  const GeneralStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPaddings.low),
            child: Center(
              child: Text(
                'Общая статистика',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          const SizedBox(height: AppPaddings.hight),
          const _ChartByQuantityUsers(),
          const SizedBox(height: AppPaddings.hight),
          const _ChartByUserOlder(),
          const SizedBox(height: AppPaddings.hight),
          const _ChartByDeficiencyActivity(),
        ],
      ),
    );
  }
}

class _ChartByQuantityUsers extends StatelessWidget {
  const _ChartByQuantityUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PieChartWidget(
      typeChart: PieChartEnum.countUsers,
      pieColor: const [AppColors.activity, AppColors.step],
      statText: const [
        TextStatistic(
          color: AppColors.activity,
          text: 'Кол-во пользователей\n мужского пола',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.step,
          text: 'Кол-во пользователей\n женского пола',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          isGradient: true,
          text: 'Общее кол-во\n пользователей',
        ),
      ],
    );
  }
}

class _ChartByUserOlder extends StatelessWidget {
  const _ChartByUserOlder({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChartWidget(
      typeChart: PieChartEnum.countUsersByAge,
      pieColor: const [
        AppColors.activity,
        AppColors.step,
        AppColors.energyConsumption
      ],
      statText: const [
        TextStatistic(
          color: AppColors.activity,
          text: 'Кол-во пользователей\n младше 18',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.step,
          text: 'Кол-во пользователей\n старше 18',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.energyConsumption,
          text: 'Общее кол-во\n пользователей\n старше 40',
        ),
      ],
    );
  }
}

class _ChartByDeficiencyActivity extends StatelessWidget {
  const _ChartByDeficiencyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChartWidget(
      typeChart: PieChartEnum.countUsersByQuantitySteps,
      pieColor: const [
        AppColors.activity,
        AppColors.step,
        AppColors.energyConsumption
      ],
      statText: const [
        TextStatistic(
          color: AppColors.activity,
          text: 'Пользователи с шагами\n меньше 5 тыс.',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.step,
          text: 'Пользователи с шагами\n меньше 15 тыс.',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.energyConsumption,
          text: 'Пользователи с шагами\n меньше 25 тыс.',
        ),
      ],
    );
  }
}
