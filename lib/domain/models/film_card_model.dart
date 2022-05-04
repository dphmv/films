abstract class FilmCard {
  const FilmCard(this.id, this.title, this.picture, this.voteAverage,
      this.releaseDate, this.description, this.language);

  final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  void aboutFilm();
}

class Film extends FilmCard with LanguageConverter {
  const Film({
    required String id,
    required String title,
    required String picture,
    required double voteAverage,
    required String releaseDate,
    required String description,
    required String language,
  }) : super(id, title, picture, voteAverage, releaseDate, description,
            language);

  @override
  void aboutFilm() {
    var languageType = getLanguage(language);
    print(
      '\nНазвание: $title,'
      '\nРейтинг: $voteAverage,'
      '\nДата выхода: $releaseDate,'
      '\nОписание: $description,'
      '\nЯзык фильма: ${languageType.toPrettyString()}',
    );
  }
}

Future<List<Film>> getFilmList() async {
  List<Film> films = getFilms();
  for (final film in films) {
    await Future.delayed(const Duration(seconds: 1));
    film.aboutFilm();
  }

  List<Film> filterFilms = _filterFilm(films);
  await Future.delayed(const Duration(seconds: 1));
  print('\nРейтинг фильма больше 9: ');
  for (final film in filterFilms) {
    film.aboutFilm();
  }
  return films;
}

List<Film> _filterFilm(List<Film> films) {
  return films.where((element) => element.voteAverage > 9).toList();
}

Future<void> main() async {
  print('Список фильмов: ');
  await getFilmList();
}

List<Film> getFilms() {
  return [
    const Film(
        id: '0',
        title: 'Зелёная миля',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/acb932eb-c7d0-42de-92df-f5f306c4c48e/1920x',
        voteAverage: 9.1,
        releaseDate: '1999-12-06',
        description: 'Обвиненный в страшном преступлении, Джон Коффи...',
        language: 'english'),
    const Film(
        id: '1',
        title: 'Побег из Шоушенка',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/e26044e5-2d5a-4b38-a133-a776ad93366f/1920x',
        voteAverage: 9.1,
        releaseDate: '1994-09-10',
        description: 'Бухгалтер Энди Дюфрейн обвинён в убийстве...',
        language: 'russian'),
    const Film(
        id: '2',
        title: 'Список Шиндлера',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/ad682589-603d-40c1-b63a-fe01af9f3012/1920x',
        voteAverage: 8.8,
        releaseDate: '1993-11-30',
        description: 'Лента рассказывает реальную историю...',
        language: 'german')
  ];
}

enum Language { english, russian, another }

mixin LanguageConverter {
  Language getLanguage(String language) {
    switch (language) {
      case 'english':
        return Language.english;
      case 'russian':
        return Language.russian;
      default:
        return Language.another;
    }
  }
}

extension LanguageExtension on Language {
  String toPrettyString() {
    switch (this) {
      case Language.english:
        return 'Английский';
      case Language.russian:
        return 'Русский';
      case Language.another:
        return 'Другой';
    }
  }
}
