import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_detail_bloc/product_detail_bloc.dart';
import '../bloc/product_detail_bloc/product_detail_state.dart';

class TitleAndRatingOverViewSection extends StatelessWidget {
  final Product product;
  const TitleAndRatingOverViewSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          maxLines: 2,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${product.rating.toStringAsFixed(1)} Ratings',
                      style: TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              BlocBuilder<ProductDetailBloc, ProductDetailBlocState>(
                builder: (context, state) {
                  if (state is ProductReviews) {
                    return Text('${state.reviews.length}+ Reviews',
                        style: TextStyle(color: Colors.grey, fontSize: 15));
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
