import 'package:ecommerce_app/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/data/network/api_service.dart';

void main(){
  
  late ApiService apiService;
  
  setUp(() {
    apiService = ApiService();
  });
  
  group('testingApiService', () { 
    test('getProducts', () async {
      //arrange
      //act
      final products = await apiService.getProducts('https://dummyjson.com/products?limit=100');

      //assert
      expect(products, isA<List<Product>>());
      
    });
  });
  
  
}