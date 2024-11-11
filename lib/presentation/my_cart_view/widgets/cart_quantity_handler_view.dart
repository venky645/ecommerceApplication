import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/cart_model.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_bloc_event.dart';
import '../bloc/cart_bloc_state.dart';

class CartQuantityHandlerView extends StatelessWidget {
  const CartQuantityHandlerView({super.key, required this.product});
  final Cart product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            child: ElevatedButton(
                onPressed: () {
                  context
                      .read<CartBloc>()
                      .add(DecrementCartQuantity(productId: '${product.id}'));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black12))),
                child: const Icon(
                  Icons.minimize,
                  size: 15,
                )),
          ),
          BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) {
              return current is CartSuccess ||
                  (current is CartQuantity &&
                      current.productId == '${product.id}');
            },
            builder: (BuildContext context, state) {
              if (state is CartSuccess) {
                final cartProduct = state.products
                    .firstWhere((element) => element.id == product.id);
                return Text('${cartProduct.quantity}');
              } else if (state is CartQuantity &&
                  state.productId == '${product.id}') {
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
                  BlocProvider.of<CartBloc>(context)
                      .add(IncrementCartQuantity(productId: '${product.id}'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.green,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.green,
                ),
              )),
        ],
      ),
    );
  }
}
