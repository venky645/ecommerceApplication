import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailEvent, ProductDetailBlocState> {
    final fireStoreDataBase;
  ProductDetailBloc({required this.fireStoreDataBase}) : super(ProductFetchLoading()) {
    on<FetchProduct>((event, emit) async {
      Product? product =
          await fireStoreDataBase?.getProductById(event.productId);
      if (product != null) {
        emit(ProductFetchSuccess(product: product));
        if (product.reviews!.isNotEmpty) {
          emit(ProductReviews(reviews: product.reviews!));
        }
      } else {
        emit(ProductFetchFailure(error: 'product fetch failed'));
      }
    });

    on<SubmitReview>((event, emit) async {
      List? reviews = await fireStoreDataBase
          ?.submitReview(event.review, event.productId);
      if (reviews != null) {
        emit(ProductReviews(reviews: reviews));
      }
    });

  }
}
