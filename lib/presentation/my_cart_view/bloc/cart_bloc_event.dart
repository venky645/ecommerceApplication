abstract class CartEvent {}

class GetAllCartProducts extends CartEvent {}

class IncrementCartQuantity extends CartEvent {
  final String productId;
  IncrementCartQuantity({required this.productId});
}

class DecrementCartQuantity extends CartEvent {
  final String productId;
  DecrementCartQuantity({required this.productId});
}

class RemoveProductFromCart extends CartEvent {
  final String productId;
  RemoveProductFromCart({required this.productId});
}

class SampleEvent extends CartEvent {}

class AddProductToCart extends CartEvent {

}
