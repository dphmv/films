import 'package:films/data/repositories/films_repository.dart';
import 'package:films/error_bloc/error_bloc.dart';
import 'package:films/error_bloc/error_event.dart';
import 'package:films/presentation/catalog/bloc/catalog_bloc.dart';
import 'package:films/presentation/catalog/catalog_page.dart';
import 'package:films/presentation/home/bloc/home_bloc.dart';
import 'package:films/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider<ErrorBloc>(
        lazy: false,
        create: (_) => ErrorBloc(),
        child: RepositoryProvider<FilmsRepository>(
          lazy: true,
          create: (BuildContext context) => FilmsRepository(
            onErrorHandler: (String code, String message) {
              context
                  .read<ErrorBloc>()
                  .add(ShowDialogEvent(title: code, message: message));
            },
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CatalogBloc>(
                lazy: false,
                create: (BuildContext context) =>
                    CatalogBloc(context.read<FilmsRepository>()),
              ),
              BlocProvider<HomeBloc>(
                lazy: false,
                create: (BuildContext context) =>
                    HomeBloc(context.read<FilmsRepository>()),
              ),
            ],
            child: MainPage._tabs.elementAt(_selectedIndex).page,
          ),
        ),
      ),
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
