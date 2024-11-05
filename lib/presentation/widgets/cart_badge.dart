import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_cart_view/bloc/cart_bloc.dart';
import '../my_cart_view/bloc/cart_bloc_state.dart';

class CartWithBadge extends StatelessWidget {
  const CartWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/myCart');
          },
          icon: Icon(Icons.shopping_cart)),
      BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => current is CartCount,
          builder: (context, state) {
            if (state is CartCount) {
              print("homepagecartcount: ${state.cartCount}");
              return state.cartCount > 0
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 23,
                        width: 23,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          '${state.cartCount}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }
            return SizedBox.shrink();
          })
    ]);
  }
}
