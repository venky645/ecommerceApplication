abstract interface class BaseApiService{
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, Map<String,String> jsonBody);
}