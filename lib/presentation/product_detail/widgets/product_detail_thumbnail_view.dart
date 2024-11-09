import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product.dart';
import '../bloc/cubit/product_detail_cubit.dart';

class ProductDetailThumbNailVew extends StatelessWidget {
  final Product product;
  const ProductDetailThumbNailVew({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, cubitState) => Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 -
                      AppBar().preferredSize.height,
                  decoration: const BoxDecoration(),
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      cubitState.productThumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                product.images!.length > 1
                    ? Positioned(
                        top: 0,
                        left: -5,
                        child: Container(
                          height: 300,
                          width: 100,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<ProductDetailCubit>(context)
                                        .updateProductThumbnail(
                                            product.images?[index]);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Image.network(
                                      product.images?[index],
                                      fit: BoxFit.fitHeight,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                );
                              },
                              itemCount: product.images?.length),
                        ))
                    : const SizedBox()
              ],
            ));
  }
}
