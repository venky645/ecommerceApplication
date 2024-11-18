import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_event.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FireStoreDataBase fireStoreDataBase;
  HomeBloc({required this.fireStoreDataBase}) : super(ProductsIntial()) {
    on<FetchAllProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        List<Product> products = await fireStoreDataBase.getAllProducts();
        if (products.isNotEmpty) {
          emit(ProductsSuccess(products));
        } else {
          emit(ProductsError('no products are found'));
        }
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });

    on<FetchProductsByCategory>((event, emit) async {
      emit(ProductsLoading());
      try {
        List<Product> products =
            await fireStoreDataBase.getProductsByCatergory(event.category);
        emit(ProductsSuccess(products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
