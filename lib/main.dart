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
