import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/network/api_service.dart';
import '../model/product.dart';

// final productsProvider = FutureProvider<List<Product>>((ref) async {
//   final apiService = ref.read(apiServiceProvider);
//   return apiService.getProducts(url);
// });

final apiServiceProvider = Provider((ref) => ApiService());
