import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Cart> products;
  CartSuccess({required this.products});
  @override
  List<Object> get props => [products];
}

class CartTotal extends CartState {
  final double cartTotal;
  CartTotal({required this.cartTotal});
  @override
  List<Object> get props => [cartTotal];
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
  @override
  List<Object> get props => [error];
}

class CartQuantity extends CartState {
  final int productQuantity;
  final String productId;

  CartQuantity({required this.productId, required this.productQuantity});
  @override
  List<Object> get props => [productQuantity, productId];
}

class CartCount extends CartState {
  final int cartCount;
  CartCount({required this.cartCount});
}

class CartProductRemovalSuccess extends CartState {}
