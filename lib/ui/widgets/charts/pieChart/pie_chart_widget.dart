import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';
import 'package:health_statistics/ui/widgets/charts/pieChart/pie_chart_view_model.dart';

class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key, required this.statText, required this.pieColor});
  final vm = PieChartViewModel();
  final List<Widget> statText;
  final List<Color> pieColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220, maxWidth: 220),
          child: FutureBuilder<void>(
            future: vm.fetchDataFromDB(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return PieChart(
                PieChartData(
                  sections: [
                    ...getCountUsers(context),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                ),
                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              );
            },
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
  }

  List<PieChartSectionData> getCountUsers(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        );
    final pieChartUsers = <PieChartSectionData>[
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
