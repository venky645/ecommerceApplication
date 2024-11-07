import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailEvent, ProductDetailBlocState> {
  ProductDetailBloc() : super(ProductFetchLoading()) {
    on<FetchProduct>((event, emit) async {
      print('getting producy id:    ${event.productId}');
      Product? product =
          await FireStoreDataBase.instance?.getProductById(event.productId);
      print('product?.price :    ${product?.price} :     ');
      if (product != null) {
        print('product.brand : ${product.brand}');
        emit(ProductFetchSuccess(product: product));
        if (product.reviews!.isNotEmpty) {
          emit(ProductReviews(reviews: product.reviews!));
        }
      } else {
        emit(ProductFetchFailure(error: 'product fetch failed'));
      }
    });

    on<SubmitReview>((event, emit) async {
      print('evereeeeeeeeeeeeeeeeeeeeeeeeeeeeee : ${event.productId}');

      List? reviews = await FireStoreDataBase.instance
          ?.submitReview(event.review, event.productId);
      if (reviews != null) {
        emit(ProductReviews(reviews: reviews));
      }
    });

    // on<UpdateProductReview>((event, emit) {

    // });
  }
}
