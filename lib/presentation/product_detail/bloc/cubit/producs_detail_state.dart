part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final bool isItemAddedToCart;
  final String productThumbnail;
  final int productQuantity;

  const ProductDetailState(
      {required this.isItemAddedToCart,
      required this.productQuantity,
      required this.productThumbnail});

  factory ProductDetailState.intial() {
    return const ProductDetailState(
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
