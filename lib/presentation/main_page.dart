import 'package:films/presentation/catalog/catalog_page.dart';
import 'package:films/presentation/home/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const path = '/';

  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
      icon: Icon(Icons.grid_view),
      label: 'Каталог',
      page: CatalogPage(),
    ),
    _Tab(
      icon: Icon(Icons.library_books),
      label: 'Список',
      page: HomePage(),
    ),
  ];

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage._tabs.elementAt(_selectedIndex).page,
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          MainPage._tabs.length,
          (index) {
            final _Tab tab = MainPage._tabs[index];
            return BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.label,
            );
          },
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

class _Tab {
  const _Tab({
    required this.icon,
    required this.label,
    required this.page,
  });

  final Icon icon;
  final String label;
  final Widget page;
}
