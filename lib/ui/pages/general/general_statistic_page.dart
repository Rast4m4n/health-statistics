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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.hight),
            child: Text(
              'Пользователей в приложении',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppPaddings.low),
          const _ChartByQuantityUsers(),
          const SizedBox(height: AppPaddings.hight),
          const _ChartByUserOlder(),
          const SizedBox(height: AppPaddings.low),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.hight),
            child: Text(
              'Рекомендуемая активность в день',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppPaddings.low),
          Padding(
            padding: const EdgeInsets.only(left: AppPaddings.low),
            child: Column(
              children: [
                Text(
                  'Рекомендуемое время аэробной активности в день - 75 минут.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppPaddings.low),
                Text(
                  'Рекомендуемое время аэробной активности в неделю - 150-300 минут.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppPaddings.low),
          const _ChartByDeficiencyActivity(),
          const SizedBox(height: AppPaddings.low),
          Padding(
            padding: const EdgeInsets.only(left: AppPaddings.low),
            child: Column(
              children: [
                Text(
                  'Рекомендуемое количество шагов в день малоподвижному человеку до 3 тысяч шагов.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppPaddings.low),
                Text(
                  'Рекомендуемое количество шагов в день здоровому взрослому человеку - 10 тысяч шагов',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppPaddings.low),
                Text(
                  'Рекомендуемое количество шагов в день физически активному человеку - 20 тысяч шагов и более',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppPaddings.low),
          const _ChartByQuantitySteps(),
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
      pieColor: const [AppColors.skyBlue, AppColors.coral],
      statText: const [
        TextStatistic(
          color: AppColors.skyBlue,
          text: 'Кол-во пользователей\n мужского пола',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.coral,
          text: 'Кол-во пользователей\n женского пола',
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
        AppColors.skyBlue,
        AppColors.coral,
        AppColors.purple,
        AppColors.green,
      ],
      statText: const [
        TextStatistic(
          color: AppColors.skyBlue,
          text: 'Кол-во пользователей\n младше 18',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.coral,
          text: 'Кол-во пользователей\n старше 18',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.purple,
          text: 'Кол-во пользователей\n старше 30',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.green,
          text: 'Кол-во пользователей\n старше 60',
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
      typeChart: PieChartEnum.countUsersByActivity,
      pieColor: const [
        AppColors.skyBlue,
        AppColors.coral,
      ],
      statText: const [
        TextStatistic(
          color: AppColors.skyBlue,
          text: 'Пользователей с\n активностью меньше\n 75 минут',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.coral,
          text: 'Пользователей с\n активностью больше\n 75 минут',
        ),
      ],
    );
  }
}

class _ChartByQuantitySteps extends StatelessWidget {
  const _ChartByQuantitySteps({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChartWidget(
      typeChart: PieChartEnum.countUsersByQuantitySteps,
      pieColor: const [
        AppColors.skyBlue,
        AppColors.coral,
        AppColors.purple,
      ],
      statText: const [
        TextStatistic(
          color: AppColors.skyBlue,
          text: 'Пользователей с кол-вом\n шагов до 3тыс.',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.coral,
          text: 'Пользователей с кол-вом\n шагов до 10тыс.',
        ),
        SizedBox(height: AppPaddings.medium),
        TextStatistic(
          color: AppColors.purple,
          text: 'Пользователей с кол-вом\n шагов до 20тыс.\n и больше.',
        ),
      ],
    );
  }
}
