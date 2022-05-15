import 'package:films/components/widgets/search_field.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:films/domain/widgets/film_list.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;

  late List<FilmCardModel> films;

  String query = '';

  @override
  void initState() {
    super.initState();

    films = FilmList.filmList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: !isSearching
            ? RichText(
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
              )
            : searchBuild(),
        actions: <Widget>[
          !isSearching
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
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
      body: const FilmList(),
    );
  }

  Widget searchBuild() => SearchField(
        text: query,
        onChanged: searchFilm,
      );

  void searchFilm(String query) {
    final films = FilmList.filmList.where((filmF) {
      final titleLower = filmF.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.films = films;
    });
  }
}
