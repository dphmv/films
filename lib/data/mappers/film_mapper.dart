import 'package:films/data/dtos/film_dto.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/domain/models/film_card_model.dart';

extension BasicFromDTOToDomain on BasicDTO {
  BasicModel toDomain() {
    return BasicModel(
      film: film?.map((FilmCardDTO e) => e.toDomain()).toList(),
    );
  }
}

extension FilmCardFromDTOToDomain on FilmCardDTO {
  FilmCardModel toDomain() {
    return FilmCardModel(
      id: id,
      title: title,
      picture: picture,
      voteAverage: voteAverage,
      releaseDate: releaseDate.toString(),
    );
  }
}
