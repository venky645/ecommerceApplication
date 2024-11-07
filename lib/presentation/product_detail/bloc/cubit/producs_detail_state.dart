part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  bool isItemAddedToCart;
  String productThumbnail;
  int productQuantity;

  ProductDetailState(
      {required this.isItemAddedToCart,
      required this.productQuantity,
      required this.productThumbnail});

  factory ProductDetailState.intial() {
    return ProductDetailState(
        isItemAddedToCart: false, productQuantity: 0, productThumbnail: '');
  }

  @override
  List<Object?> get props =>
      [isItemAddedToCart, productQuantity, productThumbnail];

  ProductDetailState copyWith(
      {isProductAddedToCart, productImage, productCartQuantity}) {
    return ProductDetailState(
        isItemAddedToCart: isProductAddedToCart ?? isItemAddedToCart,
        productQuantity: productCartQuantity ?? productQuantity,
        productThumbnail: productImage ?? productThumbnail);
  }
}
