import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_event.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetAllCartProducts>((event, emit) async {
      emit(CartLoading());
      try {
        List<Cart> products = await DataBaseHelper().getALlCartProducts();
        emit(CartSuccess(products: products));
        double cartTotal = await DataBaseHelper().cartTotal();
        emit(CartTotal(cartTotal: cartTotal));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddProductToCart>((event, emit) async {
      try {
        List<Cart> cartProducts = await DataBaseHelper().getALlCartProducts();
        print('hey hi how are u : ${cartProducts.length}');
        emit(CartCount(cartCount: cartProducts.length));
        double cartTotal = await DataBaseHelper().cartTotal();
        emit(CartTotal(cartTotal: cartTotal));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<RemoveProductFromCart>((event, emit) async {
      try {
        // emit(CartLoading());
        // List<Product> products =
        //     await FireStoreDataBase.instance!.removeProduct(event.productId);
        // int cartProductCount =
        //     await FireStoreDataBase.instance!.getCartProductCount();
        // emit(CartSuccess(products: products));
        // emit(CartCount(cartCount: cartProductCount));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<DecrementCartQuantity>((event, emit) async {
      try {
        int productQuantity =
            await DataBaseHelper().getProductQuantity(event.productId);

        if (productQuantity > 1) {
          DataBaseHelper().updateItem(event.productId, productQuantity - 1);
          emit(CartQuantity(
              productQuantity: productQuantity - 1,
              productId: event.productId));
          double cartTotal = await DataBaseHelper().cartTotal();
          emit(CartTotal(cartTotal: cartTotal));
        } else {
          int deleteItems = await DataBaseHelper().deleteItem(event.productId);
          List<Cart> cartProducts = await DataBaseHelper().getALlCartProducts();
          if (deleteItems != 0) {
            emit(CartSuccess(products: cartProducts));
            double cartTotal = await DataBaseHelper().cartTotal();
            emit(CartTotal(cartTotal: cartTotal));
          }
        }
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<IncrementCartQuantity>((event, emit) async {
      try {
        int productQuantity =
            await DataBaseHelper().getProductQuantity(event.productId);

        await DataBaseHelper().updateItem(event.productId, productQuantity + 1);
        emit(CartQuantity(
            productQuantity: productQuantity + 1, productId: event.productId));
        double cartTotal = await DataBaseHelper().cartTotal();
        emit(CartTotal(cartTotal: cartTotal));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
