import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_event.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:ecommerce_app/utils/discount_calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/cart_model.dart';

class MyCartItem extends StatelessWidget {
  const MyCartItem({super.key, required this.product});
  final Cart product;
  // final int productQuantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("dismissable_widget"),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure you want to remove the product?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green))),
              TextButton(
                  onPressed: () async {
                    await DataBaseHelper().deleteItem('${product.id}');
                    Navigator.pop(context, true);
                  },
                  child: Text('Remove',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade300)))
            ],
          ),
        );
      },
      onDismissed: (direction) {
        print('dismissed with the directio :  ${direction}');
      },
      direction: DismissDirection.endToStart,
      dismissThresholds: {DismissDirection.endToStart: 0.2},
      background: Container(
        color: Colors.orange,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 6), // changes position of shadow
                ),
              ]),
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                maxLines: 1,
                              ),
                              Text(
                                product.brand,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  '${product.discountPercentage.toStringAsFixed(2)}/- off',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '\$${discountPrice(product.discountPercentage, product.price).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            DecrementCartQuantity(
                                                productId: '${product.id}'));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: const BorderSide(
                                                  color: Colors.black12))),
                                      child: const Icon(
                                        Icons.minimize,
                                        size: 15,
                                      )),
                                ),
                                BlocBuilder<CartBloc, CartState>(
                                  buildWhen: (previous, current) {
                                    return current is CartSuccess ||
                                        (current is CartQuantity &&
                                            current.productId ==
                                                '${product.id}');
                                  },
                                  builder: (BuildContext context, state) {
                                    if (state is CartSuccess) {
                                      final cartProduct = state.products
                                          .firstWhere((element) =>
                                              element.id == product.id);
                                      return Text('${cartProduct.quantity}');
                                    } else if (state is CartQuantity &&
                                        state.productId == '${product.id}') {
                                      print("hello abcs");
                                      return Text('${state.productQuantity}');
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                                SizedBox(
                                    width: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            IncrementCartQuantity(
                                                productId: '${product.id}'));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(
                                          color: Colors.green,
                                          width:
                                              1, // Adjust border width if needed
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color:
                                            Colors.green, // Color of the icon
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ])
                  ],
                ),
              )
            ],
          )),
    );
  }
}
