import 'package:equatable/equatable.dart';
import 'package:films/domain/models/basic_model.dart';

class HomeState extends Equatable {
  const HomeState({this.data});

  final Future<BasicModel?>? data;

  HomeState copyWith({String? search, Future<BasicModel?>? data}) => HomeState(
        data: data ?? this.data,
      );

  @override
  List<Object> get props => [data ?? 0];
}
