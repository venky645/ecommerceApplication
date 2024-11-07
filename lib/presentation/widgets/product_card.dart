import 'package:flutter/material.dart';

import '../../mediaQuery/mediaquery_helper.dart';
import '../../model/product_model.dart';
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mediaQueryHelper.responsiveValue(context, 16)),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: mediaQueryHelper.responsiveValue(context, 20)),
      child: Row(
        children: [
          //Product Logo
        Container(
        width: mediaQueryHelper.responsiveHeight(context, 100),
        height: mediaQueryHelper.responsiveHeight(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            product.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
          SizedBox(width: mediaQueryHelper.responsiveWidth(context, 10)),

          //Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mediaQueryHelper.responsiveHeight(context, 250),
                  child: Text(
                    product.title!,
                    style: const TextStyle(),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: mediaQueryHelper.responsiveHeight(context, 10)),
                Text(
                  product.category!,
                  style: const TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            Icons.star_border_rounded,
                            color: Colors.yellow[600],
                            size: mediaQueryHelper.responsiveValue(context, 18),
                          ),
                        const SizedBox(width: 4),
                        Text('(${product.rating!.rate})'),
                        const SizedBox(width: 4),
                        Text('(${product.rating!.count})'),
                      ],
                    ),
                    Text('\$${product.price}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
