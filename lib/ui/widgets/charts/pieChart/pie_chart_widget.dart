import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_statistics/domain/enums/pie_chart_enum.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_view_model.dart';

class PieChartWidget extends StatelessWidget {
  PieChartWidget({
    super.key,
    required this.statText,
    required this.pieColor,
    required this.typeChart,
  });

  final List<Widget> statText;
  final List<Color> pieColor;
  final PieChartEnum typeChart;
  final vm = PieChartViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: vm.fetchDataFromDB(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (vm.quantityMen != 0 ||
            vm.quantityWomen != 0 ||
            vm.totalQuantity != 0 && vm.userOlderLow != 0 ||
            vm.userOlderMedium != 0 ||
            vm.userOlderHight != 0 && vm.userWithSmallWalk != 0 ||
            vm.userWithMediumWalk != 0 ||
            vm.userWithHightWalk != 0) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 200),
                child: PieChart(
                  PieChartData(
                    sections: [
                      ...getCountUsers(context),
                    ],
                    sectionsSpace: 0,
                    centerSpaceRadius: 60,
                  ),
                  swapAnimationDuration:
                      const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
              const SizedBox(width: AppPaddings.low),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...statText,
                ],
              ),
            ],
          );
        } else {
          // Косяк с прогресс-индикатором из-за ListView
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<PieChartSectionData> getCountUsers(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        );
    List<PieChartSectionData> pieChartUsers = [];
    if (typeChart == PieChartEnum.countUsers) {
      pieChartUsers = [
        PieChartSectionData(
          value: vm.quantityMen.toDouble(),
          color: pieColor[0],
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          value: vm.quantityWomen.toDouble(),
          color: pieColor[1],
          titleStyle: textStyle,
        ),
      ];
    } else if (typeChart == PieChartEnum.countUsersByAge) {
      pieChartUsers = [
        PieChartSectionData(
          value: vm.userOlderLow.toDouble(),
          color: pieColor[0],
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          value: vm.userOlderMedium.toDouble(),
          color: pieColor[1],
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          value: vm.userOlderHight.toDouble(),
          color: pieColor[2],
          titleStyle: textStyle,
        ),
      ];
    } else if (typeChart == PieChartEnum.countUsersByQuantitySteps) {
      pieChartUsers = [
        PieChartSectionData(
          value: vm.userWithSmallWalk.toDouble(),
          color: pieColor[0],
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          value: vm.userWithMediumWalk.toDouble(),
          color: pieColor[1],
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          value: vm.userWithHightWalk.toDouble(),
          color: pieColor[2],
          titleStyle: textStyle,
        ),
      ];
    }

    return pieChartUsers;
  }
}

class TextStatistic extends StatelessWidget {
  const TextStatistic({
    super.key,
    this.color,
    this.isGradient = false,
    required this.text,
  });
  final Color? color;
  final bool isGradient;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: isGradient ? null : color,
            shape: BoxShape.circle,
            gradient: isGradient
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.activity, AppColors.step],
                  )
                : null,
          ),
        ),
        const SizedBox(width: AppPaddings.low),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
