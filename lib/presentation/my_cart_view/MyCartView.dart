import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_event.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:ecommerce_app/presentation/my_cart_view/widgets/my_cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/cart_bottom_sheet_view.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  @override
  void initState() {
    super.initState();
    loadCartTheProducts();
  }

  void loadCartTheProducts() async {
    BlocProvider.of<CartBloc>(context).add(GetAllCartProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF5F9F9F5),
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) async {},
            buildWhen: (previous, current) {
              return current is CartSuccess || current is CartError;
            },
            builder: (context, state) {
              if (state is CartSuccess) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: MyCartItem(
                          product: state.products[index],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CartError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
          const CartViewBottomSheet()
        ],
      ),
    );
  }
}
