import 'package:films/components/constants.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/presentation/home/bloc/home_event.dart';
import 'package:films/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  final FilmsRepository repository;

  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
        data: repository.loadData(keyword: FilmQuery.initialWord)));
  }
}
