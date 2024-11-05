import 'package:ecommerce_app/model/product.dart';

abstract class HomeState{}

class ProductsIntial extends HomeState{}

class ProductsLoading extends HomeState{}

class ProductsSuccess extends HomeState{
  final List<Product> products;
  ProductsSuccess(this.products);
}

class ProductsError  extends HomeState{
  final String error;
  ProductsError(this.error);
}


