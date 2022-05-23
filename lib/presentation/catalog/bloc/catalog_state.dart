import 'package:equatable/equatable.dart';
import 'package:films/domain/models/basic_model.dart';

class CatalogState extends Equatable {
  const CatalogState({this.search, this.data});

  final String? search;
  final Future<BasicModel?>? data;

  CatalogState copyWith({String? search, Future<BasicModel?>? data}) =>
      CatalogState(
        search: search ?? this.search,
        data: data ?? this.data,
      );

  @override
  List<Object> get props => [search ?? 0, data ?? 0];
}
