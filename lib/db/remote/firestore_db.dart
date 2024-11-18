import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/network/api_endpoints.dart';
import 'package:ecommerce_app/data/network/api_service.dart';
import 'package:ecommerce_app/db/remote/base_firestore_services.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDataBase implements BaseFireStoreServices {
  late final FirebaseFirestore _firestore;

  static final FireStoreDataBase _instance = FireStoreDataBase._internal(FirebaseFirestore.instance);

  FireStoreDataBase._internal(this._firestore);

  factory FireStoreDataBase() {
    return _instance;
  }

  static FireStoreDataBase? get instance => _instance;

  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    Set<String> catergories = {};

    var data = await _firestore.collection("products").get();
    for (var product in data.docs) {
      catergories.add(product['category']);
      products.add(Product.fromJson(product.data()));
    }

    return products;
  }

  @override
  Future<List<Product>> getProductsByCatergory(String category) async {
    List<Product> products = [];
    if (category == 'All') {
      return getAllProducts();
    }
    var data = await _firestore
        .collection("products")
        .where('category', isEqualTo: category)
        .get();
    for (var product in data.docs) {
      products.add(Product.fromJson(product.data()));
    }
    return products;
  }

  @override
  Future loadProductsToFireStore() async {
    try {
      List<Product>? products =
          await ApiService().getProducts(APiEndPoints.productsUrl);
      print(products?.length);
      if (products != null) {
        for (var product in products) {
          await _firestore.collection('products').doc('${product.id}').set({
            "id": product.id,
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "discountPercentage": product.discountPercentage,
            "rating": product.rating,
            "stock": product.stock,
            "brand": product.brand,
            "category": product.category,
            "thumbnail": product.thumbnail,
            "images": product.images,
            'availabilityStatus': product.availabilityStatus,
            'dimension': product.dimension,
            'metaData': product.metaData,
            'returnPolicy': product.returnPolicy,
            'reviews': product.reviews,
            'shippingInformation': product.shippingInformation,
            'tags': product.tags,
            'warrantyInformation': product.warrantyInformation
          }).then((value) => print("successfully added products to database"));
        }
      }
    } on Exception catch (_, e) {
      print('exception...: ${e}');
    }
  }

  Future<Product?> getProductById(String productId) async {
    print('productId at getProductId :   ${productId}');
    try {
      var doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        Product product = Product.fromJson(doc.data() as Map<String, dynamic>);
        print('rating  : ${product.rating}');

        return Product.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Product not found');
        return null;
      }
    } catch (e) {
      print("got an exception at getProductId : ${e.toString()}");
    }
    return null;
  }

  Future<void> addToCart(String productID, productQuantity) async {
    if (_user != null) {
      DocumentReference userRef = _firestore.collection('users').doc(_user.uid);

      try {
        Map<String, dynamic> cartDetails = {
          'productID': productID,
          'productQuantity': productQuantity
        };
        userRef.update({
          'userCart': FieldValue.arrayUnion([cartDetails]),
        });
      } catch (e) {
        print('Error checking/initializing userCart field: $e');
      }
    } else {
      print('No user logged in');
    }
  }

  Future<(bool, dynamic)> checkProductStatus(String productId) async {
    DocumentReference documentReference =
        _firestore.collection('users').doc(_user?.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      List<dynamic> userCart = documentSnapshot.get('userCart');
      for (var userCartItem in userCart) {
        if (userCartItem['productID'] == productId) {
          return (true, userCartItem['productQuantity']);
        }
      }
    }

    return (false, 0);
  }

  Future<List<Product>> loadCartProduct() async {
    List<Product> products = [];
    if (_user != null) {
      Map<String, dynamic> userData =
          (await _firestore.collection('users').doc(_user?.uid).get()).data()
              as Map<String, dynamic>;

      List<dynamic> userCartValues = userData['userCart'];
      print(userCartValues.length);
      if (userCartValues.isNotEmpty) {
        for (var userCartItem in userCartValues) {
          Product? product = await FireStoreDataBase()
              .getProductById(userCartItem['productID']);
          products.add(product!);
        }
      }
    }
    return products;
  }

  //CRUD Operations:
  Future<List<Product>> removeProduct(String productID) async {
    List<Product> updatedCartProducts = [];
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user.uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      List<dynamic> userCartValues = userData['userCart'];
      userCartValues.removeWhere(
          (userCartItem) => userCartItem['productID'] == productID);

      for (var userCartItem in userCartValues) {
        Product? product = await getProductById(userCartItem['productID']);
        if (product != null) {
          updatedCartProducts.add(product);
        }
      }
      await _firestore.collection('users').doc(_user.uid).update({
        'userCart': userCartValues,
      });
    }

    return updatedCartProducts;
  }

  Future<void> updateProductCartQuantity(
      String productId, int productQuantity) async {
    print('updateProductCartQuantity : $productQuantity');
    DocumentReference userDoc = _firestore.collection('users').doc(_user!.uid);

    // Retrieve the current userCart array
    DocumentSnapshot userSnapshot = await userDoc.get();
    List<dynamic> userCart = userSnapshot.get('userCart');

    for (int i = 0; i < userCart.length; i++) {
      Map<String, dynamic> productMap = userCart[i];
      if (productMap['productID'] == productId) {
        if (productQuantity == 0) {
          print('product removed');
          userCart.removeAt(i);
          break;
        }
        userCart[i]['productQuantity'] = productQuantity;
        break;
      }
    }

    // Update the userCart array in Firestore
    await userDoc.update({
      'userCart': userCart, // Write the updated array back to Firestore
    });
  }

  Future<List<Product>> updateProductQuantity(
      String productId, int productQuantity) async {
    List<Product> updatedCartProducts = [];
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(_user?.uid).get();
    Map<String, dynamic> userData =
        documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> userCartData = userData['userCart'];
    for (var cartItem in userCartData) {
      if (cartItem['productID'] == productId) {
        cartItem['productQuantity'] = productQuantity;
        break;
      }
    }
    for (var userCartItem in userCartData) {
      Product? product = await getProductById(userCartItem['productID']);
      if (product != null) {
        updatedCartProducts.add(product);
      }
    }

    await _firestore.collection('users').doc(_user?.uid).update({
      'userCart': userCartData,
    });
    return updatedCartProducts;
  }

  Future<void> updateStock(productId) async {}

  Future<int> getCartProductCount() async {
    DocumentSnapshot userDocSnapShot =
        await _firestore.collection('users').doc(_user!.uid).get();
    return userDocSnapShot.get('userCart').length;
  }

  Future<int> getProductQuantity(String productId) async {
    var productStatus = await checkProductStatus(productId);
    return productStatus.$2;
  }

  Future<List?> submitReview(
      Map<String, dynamic> review, String productId) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('products').doc(productId);

      List reviews = [];

      DocumentSnapshot docSnapShot = await docRef.get();
      if (docSnapShot.exists) {
        reviews = docSnapShot.get('reviews');
        print('reviews length is so so ando ssiii:  ${reviews.length}    ::::');

        reviews.add(review);
      }
      if (reviews.isNotEmpty) {
        await docRef.update({'reviews': reviews});
        return reviews;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
