abstract interface class BaseApiService{
  Future<dynamic> getProducts(String url);
  Future<dynamic> post(String url, Map<String,String> jsonBody);
}