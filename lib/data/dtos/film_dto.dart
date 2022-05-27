import 'package:json_annotation/json_annotation.dart';

part 'film_dto.g.dart';

@JsonSerializable()
class BasicDTO {
  BasicDTO({this.film});

  @JsonKey(name: 'items')
  final List<FilmCardDTO>? film;

  factory BasicDTO.fromJson(Map<String, dynamic> json) =>
      _$BasicDTOFromJson(json);
}

@JsonSerializable()
class FilmCardDTO {
  FilmCardDTO({
    required this.id,
    required this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
  });

  @JsonKey(name: 'kinopoiskId', defaultValue: 0)
  final int id;

  @JsonKey(name: 'nameOriginal', defaultValue: '')
  final String title;

  @JsonKey(name: 'posterUrl')
  final String? picture;

  @JsonKey(name: 'ratingKinopoisk', defaultValue: 0)
  final double? voteAverage;

  @JsonKey(name: 'year')
  final int? releaseDate;

  factory FilmCardDTO.fromJson(Map<String, dynamic> json) =>
      _$FilmCardDTOFromJson(json);
}
