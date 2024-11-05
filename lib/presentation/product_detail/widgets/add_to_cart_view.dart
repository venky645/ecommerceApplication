import 'package:ecommerce_app/presentation/product_detail/bloc/cubit/product_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartView extends StatelessWidget {
  final String productId;
  final Function addProductToCart;

  const AddToCartView(
      {super.key, required this.productId, required this.addProductToCart});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) => !state.isItemAddedToCart
            ? Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.green,
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      addProductToCart();
                    },
                    child: Text('Add to Cart')),
              )
            : Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<ProductDetailCubit>()
                              .decrementProductQuantity(productId);
                        },
                        icon: Icon(
                          CupertinoIcons.minus,
                          color: Colors.white,
                        )),
                    Container(
                      width: 50,
                      height: 65,
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.bag,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3),
                          Text(
                            '${state.productQuantity}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<ProductDetailCubit>()
                              .incrementProductQuantity(productId);
                        },
                        icon: const Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
