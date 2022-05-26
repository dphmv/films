import 'package:films/data/db/database.dart';

class FilmCardModel {
  const FilmCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
  });

  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
}

extension FilmCardModelToDatabase on FilmCardModel {
  FilmTableData toDatabase() {
    return FilmTableData(
      id: id,
      title: title,
      picture: picture,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      description: description,
    );
  }
}

extension FilmTableDataToDomain on FilmTableData {
  FilmCardModel toDomain() {
    return FilmCardModel(
      id: id,
      title: title,
      picture: picture,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      description: description,
    );
  }
}
