import 'package:equatable/equatable.dart';

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
