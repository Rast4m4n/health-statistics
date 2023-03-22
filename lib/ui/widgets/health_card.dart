import 'package:flutter/material.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';

class HealthCard extends StatelessWidget {
  const HealthCard({
    super.key,
    required this.title,
    required this.statistic,
    required this.color,
    this.isFullWidth = false,
  });

  final String title;
  final String statistic;
  final Color color;
  final bool isFullWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: isFullWidth
          ? double.infinity
          : MediaQuery.of(context).size.width / 2 - 21,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.low),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppPaddings.low),
            Text(
              statistic,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppPaddings.medium),
          ],
        ),
      ),
    );
  }
}
