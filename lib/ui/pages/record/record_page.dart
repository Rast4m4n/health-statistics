import 'package:flutter/material.dart';
import 'package:health_statistics/data/api/services/health_api.dart';
import 'package:health_statistics/data/api/services/user_api.dart';
import 'package:health_statistics/data/repository/health_statistics_repository.dart';
import 'package:health_statistics/ui/pages/record/record_view_model.dart';
import 'package:health_statistics/ui/themes/app_paddings.dart';
import 'package:health_statistics/ui/themes/app_theme.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});
  final vm = const RecordViewModel(
    repo: HealthStatisticsRepository(
      healthApi: HealthApi(),
      userApi: UserApi(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Таблица рекордов',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            const SizedBox(height: AppPaddings.low),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPaddings.low),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListRecords(vm: vm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListRecords extends StatelessWidget {
  const ListRecords({
    super.key,
    required this.vm,
  });

  final RecordViewModel vm;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: vm.recordBySteps(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final recordList = snapshot.data!;
          return Column(
            children: recordList,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
