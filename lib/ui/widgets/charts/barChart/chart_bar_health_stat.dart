import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_statistics/domain/models/theme_switcher.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';
import 'package:health_statistics/ui/themes/app_theme_ext.dart';
import 'package:health_statistics/ui/widgets/charts/barChart/chart_bar_view_model.dart';

class ChartsBarHealthStat extends StatefulWidget {
  const ChartsBarHealthStat({
    super.key,
  });

  @override
  State<ChartsBarHealthStat> createState() => _ChartsBarHealthStatState();
}

class _ChartsBarHealthStatState extends State<ChartsBarHealthStat> {
  ChartBarViewModel barData = const ChartBarViewModel();

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return FutureBuilder<List<Bar>>(
      future: barData.fetchDataFromDB(),
      builder: (BuildContext context, AsyncSnapshot<List<Bar>> snapshot) {
        if (snapshot.hasData) {
          List<Bar> data = snapshot.data!;
          return BarChart(
            _barChartData(data, context),
            swapAnimationDuration: const Duration(milliseconds: 150),
            swapAnimationCurve: Curves.linear,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  BarChartData _barChartData(List<Bar> data, context) {
    return BarChartData(
      maxY: 25000,
      titlesData: _titlesData(),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      barGroups: data
          .map(
            (e) => BarChartGroupData(
              x: e.xAxis,
              barRods: [
                BarChartRodData(
                  toY: e.yAxisSteps,
                  color: Theme.of(context)
                      .extension<AppColorsCardExt>()!
                      .stepColor!,
                ),
                BarChartRodData(
                  toY: e.yAxisCalories!,
                  color: Theme.of(context)
                      .extension<AppColorsCardExt>()!
                      .burnedEnergyColor!,
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: _getNameTitles,
        ),
      ),
    );
  }

  Widget _getNameTitles(double value, TitleMeta meta) {
    String text;

    switch (value.toInt()) {
      case 1:
        text = 'пн';
        break;
      case 2:
        text = 'вт';
        break;
      case 3:
        text = 'ср';
        break;
      case 4:
        text = 'чт';
        break;
      case 5:
        text = 'пт';
        break;
      case 6:
        text = 'сб';
        break;
      case 7:
        text = 'вс';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          color: ThemeSwitcher.isDark ? AppColors.white : AppColors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
