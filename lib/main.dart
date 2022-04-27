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
    print('\nНазвание: $title,'
        '\nРейтинг: $voteAverage,'
        '\nДата выхода: $releaseDate,'
        '\nОписание: $description,'
        '\nЯзык фильма: ${languageType.toPrettyString()}');
  }
}

Future<List<Film>> getFilmList() async {
  List<Film> films = _getFilms();
  for (final film in films) {
    await Future.delayed(const Duration(seconds: 1));
    film.aboutFilm();
  }
  List<Film> filterFilms = _filterFilm(films);
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

List<Film> _getFilms() {
  return [
    const Film(
        id: '0',
        title: 'Зелёная миля',
        picture: 'img',
        voteAverage: 9.1,
        releaseDate: '2000-03-03',
        description: 'Обвиненный в страшном преступлении, Джон Коффи...',
        language: 'english'),
    const Film(
        id: '1',
        title: 'Побег из Шоушенка',
        picture: 'img',
        voteAverage: 8.9,
        releaseDate: '1995-02-17',
        description: 'Бухгалтер Энди Дюфрейн обвинён в убийстве...',
        language: 'russian'),
    const Film(
        id: '2',
        title: 'Список Шиндлера',
        picture: 'img',
        voteAverage: 8.8,
        releaseDate: '1994-02-18',
        description: 'Лента рассказывает реальную историю...',
        language: 'another')
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
