import 'package:ecommerce_app/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{}

class ProductsIntial extends HomeState{
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends HomeState{
  @override
  List<Object?> get props => [];
}

class ProductsSuccess extends HomeState{
  final List<Product> products;
  ProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsError  extends HomeState{
  final String error;
  ProductsError(this.error);

  @override
  List<Object?> get props => [error];
}


