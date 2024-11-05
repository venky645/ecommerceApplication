class Product {
  int id;
  String title;
  String description;
  num price;
  num discountPercentage;
  num rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List? images;
  List? tags;
  Map? dimension;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  List? reviews;
  String returnPolicy;
  Map? metaData;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images,
      required this.availabilityStatus,
      required this.dimension,
      required this.metaData,
      required this.returnPolicy,
      required this.reviews,
      required this.shippingInformation,
      required this.tags,
      required this.warrantyInformation});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountPercentage: json['discountPercentage'],
        rating: json['rating'],
        stock: json['stock'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images'],
        availabilityStatus: json['availabilityStatus'],
        dimension: json['dimension'],
        metaData: json['meta'],
        returnPolicy: json['returnPolicy'],
        reviews: json['reviews'],
        shippingInformation: json['shippingInformation'],
        tags: json['tags'],
        warrantyInformation: json['warrantyInformation']);
  }
}
