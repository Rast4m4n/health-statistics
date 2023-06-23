import 'package:flutter/material.dart';
import 'package:health_statistics/domain/models/theme_switcher.dart';
import 'package:health_statistics/ui/pages/general/general_statistic_page.dart';
import 'package:health_statistics/ui/pages/personal/personal_statistic_page.dart';
import 'package:health_statistics/ui/pages/record/record_page.dart';
import 'package:health_statistics/ui/themes/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StatelessWidget> _page = [
    PersonalStatisticPage(),
    const GeneralStatisticPage(),
    const RecordPage(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String titleName() {
    switch (_selectedIndex) {
      case 0:
        return 'Личная статистика';
      case 1:
        return 'Общая статистика';
      case 2:
        return 'Таблица рекордов';
      default:
        return 'личная статистика';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleName(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // Смена темы приложения
        // actions: [
        //   IconButton(
        //     splashRadius: 18,
        //     splashColor:
        //         ThemeSwitcher.isDark ? AppColors.white : AppColors.bgDark,
        //     color: ThemeSwitcher.isDark ? AppColors.bgDark : AppColors.white,
        //     onPressed: ThemeSwitcher.instance.switchTheme,
        //     icon: ThemeSwitcher.isDark
        //         ? const Icon(Icons.dark_mode, color: AppColors.white)
        //         : const Icon(Icons.light_mode, color: AppColors.bgDark),
        //   ),
        // ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _page.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Личная статистика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Общие показатели',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Таблица рекордов',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
