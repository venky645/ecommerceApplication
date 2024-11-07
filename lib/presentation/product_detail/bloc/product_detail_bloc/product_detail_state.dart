import 'package:ecommerce_app/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailBlocState extends Equatable {
  const ProductDetailBlocState();
  @override
  List<Object?> get props => [];
}

class ProductFetchLoading extends ProductDetailBlocState {}

class ProductFetchSuccess extends ProductDetailBlocState {
  final Product product;
  const ProductFetchSuccess({required this.product});
  @override
  List<Object?> get props => [product];
}

class ProductFetchFailure extends ProductDetailBlocState {
  final String error;
  const ProductFetchFailure({required this.error});
  @override
  List<Object?> get props => [error];
}

class ProductReviews extends ProductDetailBlocState {
  final List<dynamic> reviews;
  const ProductReviews({required this.reviews});
  @override
  List<Object?> get props => [reviews];
}
