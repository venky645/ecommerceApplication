
import 'package:academy_course/model/product_model.dart';
import 'package:academy_course/service/ApiService.dart';
import 'package:riverpod/riverpod.dart';


final productsProvider = FutureProvider<List<Product>>((ref) async{
    final apiService = ref.read(apiServiceProvider);
    return apiService.getResponse();
});

final apiServiceProvider = Provider((ref) => ApiService());
