import 'dart:convert';
import 'package:ecommerce_app/data/network/base_api_services.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService implements BaseApiService {
  @override
  Future<List<Product>?> getProducts(String url) async {
    print('step 1');
    List<Product> products = [];
    late int statucode;
    try {
      final response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);
      statucode = response.statusCode;

      print('step 2 : statusCode : $statucode');

      if (response.statusCode == 200) {
        print('step 3 : products  : ${responseData['products']}');
        for (var product in responseData['products']) {
          try {
            products.add(Product.fromJson(product));
          } catch (e) {
            print(
                'exception occur during json serialization : ${e.toString()}');
          }
        }
        return products;
      }
    } catch (e) {
      throw Exception(
          'some error occurred, status code : $statucode, error:$e');
    }
    return null;
  }

  @override
  Future post(String url, Map<String, String> jsonBody) {
    throw UnimplementedError();
  }
}
