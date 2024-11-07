abstract interface class BaseFireStoreServices {
  void loadProductsToFireStore();
  Future<dynamic> getAllProducts();
  Future<dynamic> getProductsByCatergory(String category);
}
