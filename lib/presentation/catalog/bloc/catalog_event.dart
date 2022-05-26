import 'package:equatable/equatable.dart';
import 'package:films/domain/models/film_card_model.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class SearchChangedEvent extends CatalogEvent {
  const SearchChangedEvent({required this.search});

  final String search;

  @override
  List<Object> get props => [search];
}

class LoadDataEvent extends CatalogEvent {}

class ChangedFavourites extends CatalogEvent {
  const ChangedFavourites({required this.model});

  final FilmCardModel? model;
}

class ChangedFilmsDB extends CatalogEvent {
  const ChangedFilmsDB({required this.models});

  final List<FilmCardModel> models;
}
