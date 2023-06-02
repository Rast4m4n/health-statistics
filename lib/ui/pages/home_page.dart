import 'package:flutter/material.dart';
import 'package:health_statistics/ui/pages/general/general_statistic_page.dart';
import 'package:health_statistics/ui/pages/personal/personal_statistic_page.dart';
import 'package:health_statistics/ui/pages/record/record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List<StatelessWidget> _page = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
