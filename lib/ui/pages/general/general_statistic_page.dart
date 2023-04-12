import 'package:flutter/material.dart';
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
          PieChartWidget(
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
          )
        ],
      ),
    );
  }
}
