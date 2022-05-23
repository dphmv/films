import 'package:films/components/constants.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/presentation/catalog/bloc/catalog_event.dart';
import 'package:films/presentation/catalog/bloc/catalog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this.repository) : super(const CatalogState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);
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
}
