// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicDTO _$BasicDTOFromJson(Map<String, dynamic> json) => BasicDTO(
      film: (json['items'] as List<dynamic>?)
          ?.map((e) => FilmCardDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasicDTOToJson(BasicDTO instance) => <String, dynamic>{
      'items': instance.film,
    };

FilmCardDTO _$FilmCardDTOFromJson(Map<String, dynamic> json) => FilmCardDTO(
      id: json['kinopoiskId'] as int? ?? 0,
      title: json['nameOriginal'] as String? ?? '',
      picture: json['posterUrl'] as String?,
      voteAverage: (json['ratingKinopoisk'] as num?)?.toDouble() ?? 0,
      releaseDate: json['year'] as int?,
    );

Map<String, dynamic> _$FilmCardDTOToJson(FilmCardDTO instance) =>
    <String, dynamic>{
      'kinopoiskId': instance.id,
      'nameOriginal': instance.title,
      'posterUrl': instance.picture,
      'ratingKinopoisk': instance.voteAverage,
      'year': instance.releaseDate,
    };
