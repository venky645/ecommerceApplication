import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../model/cart_model.dart';
import '../../../../model/product.dart';
import '../../../my_cart_view/bloc/cart_bloc.dart';
import '../../../my_cart_view/bloc/cart_bloc_event.dart';

part 'producs_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final DataBaseHelper dataBaseHelper;
  ProductDetailCubit({required this.dataBaseHelper})
      : super(ProductDetailState.intial());

  void updateProductThumbnail(String productImage) async {
    emit(state.copyWith(productImage: productImage));
  }

  Future<void> addItemToCart(
      Product product, VoidCallback addToCartCallBck) async {
    try {
      Cart cartItem = Cart(
          id: product.id,
          title: product.title,
          thumbnail: product.thumbnail,
          price: product.price.toDouble(),
          quantity: 1,
          brand: product.brand,
          discountPercentage: product.discountPercentage.toDouble());

      int productID = await dataBaseHelper.insertItem(cartItem.toJson());
      if (productID != 0) {
        addToCartCallBck();
        emit(
            state.copyWith(isProductAddedToCart: true, productCartQuantity: 1));
      } else {
        //TODO: need to separate this UI from the logic
        // Fluttertoast.showToast(
        //     msg: 'some issue occured while adding item to cart');
        print('some issue occured while adding item to cart');
      }
    } catch (e) {
      //TODO: need to separate this UI from the logic
      // Fluttertoast.showToast(
      //     msg: 'e.toString()');
      print(e.toString());
    }
  }

  Future<void> checkingProductStatus(String productId) async {
    int productQuantity = await dataBaseHelper.getProductQuantity(productId);
    if (productQuantity != 0) {
      emit(state.copyWith(
          isProductAddedToCart: true, productCartQuantity: productQuantity));
    } else {
      emit(state.copyWith(isProductAddedToCart: false));
    }
  }

  Future<void> incrementProductQuantity(String productID) async {
    int productQuantity = await dataBaseHelper.getProductQuantity(productID);
    if (productQuantity > 0) {
      dataBaseHelper.updateItem(productID, productQuantity + 1);
      emit(state.copyWith(productCartQuantity: productQuantity + 1));
    }
  }

  Future<void> decrementProductQuantity(String productId) async {
    int productQuantity = await dataBaseHelper.getProductQuantity(productId);
    if (productQuantity > 1) {
      await dataBaseHelper.updateItem(productId, productQuantity - 1);
      emit(state.copyWith(productCartQuantity: productQuantity - 1));
    } else {
      await dataBaseHelper.deleteItem(productId);
      emit(state.copyWith(productCartQuantity: 0, isProductAddedToCart: false));
    }
  }
}
