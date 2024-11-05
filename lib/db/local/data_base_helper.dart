import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/utils/discount_calculation.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper._internal();
  static Database? _database;

  DataBaseHelper._internal();

  factory DataBaseHelper() {
    return _instance;
  }
  DataBaseHelper get instance => _instance;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(join(path, 'app_database.db'),
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 2);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cartItems(
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT,
    price INTEGER,
    quantity INTEGER,
    thumbnail TEXT,
    brand TEXT,
    discountPercentage REAL
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db
          .execute('ALTER TABLE cartItems ADD COLUMN discountPercentage REAL');
    }
  }

  Future<int> insertItem(Map<String, dynamic> cartItem) async {
    final db = await database;
    return await db.insert('cartItems', cartItem);
  }

  Future<List<Cart>> getALlCartProducts() async {
    final db = await database;
    List<Cart> products = [];
    var cartProducts = await db.query('cartItems');
    for (var item in cartProducts) {
      products.add(Cart.fromJson(item));
    }
    return products;
  }

  Future<void> updateItem(String id, int quantity) async {
    final db = await database;
    Map<String, dynamic> updateValues = {'quantity': quantity};

    await db.update('cartItems', updateValues, where: 'id = $id');
  }

  Future<int> deleteItem(String id) async {
    final db = await database;
    return await db.delete(
      'cartItems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getProductQuantity(String productID) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'cartItems',
      columns: ['quantity'],
      where: 'id = $productID',
    );

    if (result.isNotEmpty) {
      return result.first['quantity'];
    } else {
      return 0;
    }
  }

  Future<void> clearDb() async {
    final db = await database;
    await db.delete('cartItems');
  }

  Future<double> cartTotal() async {
    List<Cart> cartProducts = await getALlCartProducts();
    double cartTotalWithDiscount = 0;
    // double cartTotalWithoutDiscount = 0;
    for (Cart item in cartProducts) {
      cartTotalWithDiscount +=
          discountPrice(item.discountPercentage, item.price) * item.quantity;
      // cartTotalWithoutDiscount += item.price * item.quantity;
    }
    return
        //(
        cartTotalWithDiscount;
    //, cartTotalWithoutDiscount - cartTotalWithDiscount);
  }
}
