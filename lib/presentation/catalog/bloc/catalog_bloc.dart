import 'package:collection/collection.dart';
import 'package:films/components/constants.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:films/presentation/catalog/bloc/catalog_event.dart';
import 'package:films/presentation/catalog/bloc/catalog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this.repository) : super(const CatalogState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);

    on<ChangedFavourites>(_onClickFavourites);
    on<ChangedFilmsDB>(_onChangedDB);

    repository.onChangedFilmsDB().listen((List<FilmCardModel> changedFilmsDB) {
      add(ChangedFilmsDB(models: changedFilmsDB));
    });
  }

  final FilmsRepository repository;

  String get search {
    final stateSearch = state.search;
    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : FilmQuery.initialWord;
  }

  void _onSearchChanged(SearchChangedEvent event, Emitter<CatalogState> emit) {
    emit(state.copyWith(search: event.search));
    emit(state.copyWith(data: repository.loadData(keyword: search)));
  }

  void _onLoadData(LoadDataEvent event, Emitter<CatalogState> emit) {
    emit(state.copyWith(data: repository.loadData(keyword: search)));
  }

  void _onClickFavourites(
      ChangedFavourites event, Emitter<CatalogState> emit) async {
    final FilmCardModel? targetFilm = event.model;

    FilmCardModel? film;

    if (state.favouritesFilms?.isNotEmpty == true) {
      film = state.favouritesFilms
          ?.firstWhereOrNull((element) => element.id == targetFilm?.id);
    }

    if (film != null) {
      await repository.deleteFilmDB(film.id);
    } else if (targetFilm != null) {
      await repository.insertFilmDB(targetFilm);
    }
  }

  void _onChangedDB(ChangedFilmsDB event, Emitter<CatalogState> emit) {
    emit(state.copyWith(favouritesFilms: event.models));
  }
}
