import 'dart:convert';
import 'package:ecommerce_app/data/network/base_api_services.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> getResponse() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Product> products =
            jsonResponse.map((e) => Product.fromJson(e)).toList();
        return products;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load products');
    }
  }
}
