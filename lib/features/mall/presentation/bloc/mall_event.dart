import 'package:equatable/equatable.dart';

abstract class MallEvent extends Equatable {
  const MallEvent();

  @override
  List<Object> get props => [];
}

class LoadMallProducts extends MallEvent {
  const LoadMallProducts();
}

class SearchProducts extends MallEvent {
  final String query;

  const SearchProducts({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterProducts extends MallEvent {
  final Map<String, dynamic> filters;

  const FilterProducts({required this.filters});

  @override
  List<Object> get props => [filters];
}
