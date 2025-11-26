import 'package:equatable/equatable.dart';
import 'package:mall_mobile_test/features/home/domain/entities/home_data_entitiy.dart';
import 'package:mall_mobile_test/features/mall/data/models/product_models.dart';

abstract class HomeState extends Equatable {
  final List<ProductModel> products;
  const HomeState({this.products = const []});

  @override
  List<Object> get props => [products];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeDataEntity data;
  final List<ProductModel> products;

  const HomeLoaded({required this.data, this.products = const []});

  @override
  List<Object> get props => [data, products];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
