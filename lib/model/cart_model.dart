class Cart {
  final int id;
  final String title;
  final String thumbnail;
  final num price;
  final int quantity;
  final String brand;
  final double discountPercentage;
  Cart(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.price,
      required this.quantity,
      required this.brand,
      required this.discountPercentage});
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json['id'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        price: json['price'],
        quantity: json['quantity'],
        brand: json['brand'],
        discountPercentage: json['discountPercentage']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
      'brand': brand,
      'discountPercentage': discountPercentage
    };
  }
}
