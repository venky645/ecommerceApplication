import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBottomSheet extends StatefulWidget {
  const CartViewBottomSheet({super.key});

  @override
  State<CartViewBottomSheet> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CartViewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(1, 6),
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                ),
                BlocBuilder<CartBloc, CartState>(
                    buildWhen: (previous, current) {
                  if (current is CartTotal) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is CartTotal) {
                    return Text('\$${state.cartTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold));
                  }
                  return const Text('0000');
                })
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrangeAccent),
                ),
                onPressed: () {},
                child: const Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white),
                )),
            const Spacer(
              flex: 1,
            )
          ],
        ));
  }
}
