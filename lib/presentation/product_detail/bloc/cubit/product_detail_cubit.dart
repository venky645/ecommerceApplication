import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'producs_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailState.intial());

  void updateProductThumbnail(String productId) async {
    Product? product =
        await FireStoreDataBase.instance?.getProductById(productId);
    emit(state.copyWith(productImage: product!.thumbnail));
  }

  void addItemToCart() async {
    emit(state.copyWith(isProductAddedToCart: true, productCartQuantity: 1));
  }

  void checkingProductStatus(String productId) async {
    int productQuantity = await DataBaseHelper().getProductQuantity(productId);
    if (productQuantity != 0) {
      emit(state.copyWith(
          isProductAddedToCart: true, productCartQuantity: productQuantity));
    } else {
      emit(state.copyWith(isProductAddedToCart: false));
    }
  }

  void incrementProductQuantity(String productID) async {
    int productQuantity = await DataBaseHelper().getProductQuantity(productID);
    if (productQuantity > 0) {
      DataBaseHelper().updateItem(productID, productQuantity + 1);
      emit(state.copyWith(productCartQuantity: productQuantity + 1));
    }
  }

  void decrementProductQuantity(String productId) async {
    int productQuantity = await DataBaseHelper().getProductQuantity(productId);
    if (productQuantity > 1) {
      await DataBaseHelper().updateItem(productId, productQuantity - 1);
      emit(state.copyWith(productCartQuantity: productQuantity - 1));
    } else {
      await DataBaseHelper().deleteItem(productId);
      emit(state.copyWith(productCartQuantity: 0, isProductAddedToCart: false));
    }
  }
}
