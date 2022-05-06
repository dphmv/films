import 'package:flutter/material.dart';
import 'package:films/domain/models/film_card_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Фильмы',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Film> films = [];

  bool isChecked = false;

  @override
  void initState() {
    getFilms().then((value) {
      setState(() {
        films = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список фильмов'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? changeValue) {
                    setState(() {
                      isChecked = changeValue ?? false;
                    });
                  },
                ),
                const Text('Только на русском'),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await getFilms().then((valueFilms) {
                  setState(() {
                    if (isChecked) {
                      films = valueFilms
                          .where((element) => element.language == 'russian')
                          .toList();
                    } else {
                      films = valueFilms;
                    }
                  });
                });
              },
              child: const Text('Тык!'),
            ),
            ...List.generate(films.length, (index) {
              return FilmCard(
                title: films[index].title,
                language: films[index]
                    .getLanguage(films[index].language)
                    .toPrettyString(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FilmCard extends StatelessWidget {
  const FilmCard({
    Key? key,
    required this.title,
    required this.language,
  }) : super(key: key);

  final String title;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              'https://www.meme-arsenal.com/memes/d6d9b7815ea8869153daa96c015ea875.jpg',
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Название: ' + title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Язык фильма: ' + language,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
