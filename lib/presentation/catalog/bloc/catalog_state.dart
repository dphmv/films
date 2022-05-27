import 'package:equatable/equatable.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/domain/models/film_card_model.dart';

class CatalogState extends Equatable {
  const CatalogState({this.search, this.data, this.favouritesFilms});

  final String? search;
  final Future<BasicModel?>? data;
  final List<FilmCardModel>? favouritesFilms;

  CatalogState copyWith({
    String? search,
    Future<BasicModel?>? data,
    List<FilmCardModel>? favouritesFilms,
  }) =>
      CatalogState(
        search: search ?? this.search,
        data: data ?? this.data,
        favouritesFilms: favouritesFilms ?? this.favouritesFilms,
      );

  @override
  List<Object> get props => [search ?? 0, data ?? 0, favouritesFilms ?? []];
}
