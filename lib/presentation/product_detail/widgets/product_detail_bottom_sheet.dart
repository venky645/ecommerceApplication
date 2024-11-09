import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/add_to_cart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../db/local/data_base_helper.dart';
import '../../../model/cart_model.dart';
import '../../../utils/discount_calculation.dart';
import '../../my_cart_view/bloc/cart_bloc.dart';
import '../../my_cart_view/bloc/cart_bloc_event.dart';
import '../bloc/cubit/product_detail_cubit.dart';

class ProductDetailBottomSheetView extends StatefulWidget {
  const ProductDetailBottomSheetView({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailBottomSheetView> createState() =>
      _ProductDetailBottomSheetViewState();
}

class _ProductDetailBottomSheetViewState
    extends State<ProductDetailBottomSheetView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          boxShadow: [BoxShadow(color: Colors.grey)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.trending_down,
                        color: CupertinoColors.activeGreen,
                      ),
                      Text(
                        '%${widget.product.discountPercentage.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.activeGreen),
                      )
                    ],
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '\$${discountPrice(widget.product.discountPercentage, widget.product.price).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          SizedBox(width: 10),
          AddToCartView(
            productId: widget.product.id.toString(),
            addProductToCart: () {
              addProductToCart(widget.product);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addProductToCart(Product product) async {
    try {
      Cart cartItem = Cart(
          id: product.id,
          title: product.title,
          thumbnail: product.thumbnail,
          price: product.price as double,
          quantity: 1,
          brand: product.brand,
          discountPercentage: product.discountPercentage as double);

      int productID = await DataBaseHelper().insertItem(cartItem.toJson());
      if (productID != 0) {
        if (mounted) {
          context.read<ProductDetailCubit>().addItemToCart();
          context.read<CartBloc>().add(AddProductToCart());
        }
      } else {
        Fluttertoast.showToast(
            msg: 'some issue occured while adding item to cart');
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
