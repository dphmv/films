import 'package:films/domain/widgets/film_grid.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'MAD',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
              TextSpan(text: ' Films'),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
                arguments: const SettingsArguments('dph.develop@gmail.com'),
              );
            },
          ),
        ],
      ),
      body: const FilmGrid(),
    );
  }
}
