import 'package:equatable/equatable.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';

abstract class MallState extends Equatable {
  final List<ProductModel> products;
  final String? searchQuery;

  const MallState({this.products = const [], this.searchQuery});

  @override
  List<Object?> get props => [products, searchQuery];
}

class MallInitial extends MallState {}

class MallLoading extends MallState {}

class MallLoaded extends MallState {
  const MallLoaded({required List<ProductModel> products, String? searchQuery})
    : super(products: products, searchQuery: searchQuery);

  @override
  List<Object?> get props => [products, searchQuery];
}

class MallError extends MallState {
  final String message;

  const MallError({required this.message, required List<ProductModel> products})
    : super(products: products);

  @override
  List<Object?> get props => [message, products];
}
