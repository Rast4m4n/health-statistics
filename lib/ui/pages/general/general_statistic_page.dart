import 'package:flutter/material.dart';
import 'package:health_statistics/domain/enums/pie_chart_enum.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_widget.dart';

class GeneralStatisticPage extends StatelessWidget {
  const GeneralStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.hight),
          child: Text(
            'Пользователей в приложении',
            style: Theme.of(context).textTheme.headlineSmall,
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
            style: Theme.of(context).textTheme.headlineSmall,
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
    );
  }
}

class _ChartByQuantityUsers extends StatelessWidget {
  const _ChartByQuantityUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Column(
      children: [
        PieChartWidget(
          typeChart: PieChartEnum.countUsers,
          pieColor: [AppColors.activity, AppColors.steps],
          statText: [
            TextStatistic(
              color: AppColors.activity,
              text: 'Кол-во пользователей\n мужского пола',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.steps,
              text: 'Кол-во пользователей\n женского пола',
            ),
          ],
        ),
      ],
    );
  }
}

class _ChartByUserOlder extends StatelessWidget {
  const _ChartByUserOlder({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Column(
      children: [
        PieChartWidget(
          typeChart: PieChartEnum.countUsersByAge,
          pieColor: [
            AppColors.activity,
            AppColors.steps,
            AppColors.burnedEnergy,
          ],
          statText: [
            TextStatistic(
              color: AppColors.activity,
              text: 'Кол-во пользователей\n младше 18',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.steps,
              text: 'Кол-во пользователей\n старше 18',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.burnedEnergy,
              text: 'Кол-во пользователей\n старше 30',
            ),
          ],
        ),
      ],
    );
  }
}

class _ChartByDeficiencyActivity extends StatelessWidget {
  const _ChartByDeficiencyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Column(
      children: [
        PieChartWidget(
          typeChart: PieChartEnum.countUsersByActivity,
          pieColor: [
            AppColors.activity,
            AppColors.steps,
          ],
          statText: [
            TextStatistic(
              color: AppColors.activity,
              text: 'Пользователей с\n активностью меньше\n 75 минут',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.steps,
              text: 'Пользователей с\n активностью больше\n 75 минут',
            ),
          ],
        ),
      ],
    );
  }
}

class _ChartByQuantitySteps extends StatelessWidget {
  const _ChartByQuantitySteps({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Column(
      children: [
        PieChartWidget(
          typeChart: PieChartEnum.countUsersByQuantitySteps,
          pieColor: [
            AppColors.activity,
            AppColors.steps,
            AppColors.burnedEnergy,
          ],
          statText: [
            TextStatistic(
              color: AppColors.activity,
              text: 'Пользователей с кол-вом\n шагов до 3тыс.',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.steps,
              text: 'Пользователей с кол-вом\n шагов до 10тыс.',
            ),
            const SizedBox(height: AppPaddings.medium),
            TextStatistic(
              color: AppColors.burnedEnergy,
              text: 'Пользователей с кол-вом\n шагов до 20тыс.\n и больше.',
            ),
          ],
        ),
      ],
    );
  }
}
