import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/utils/discount_calculation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 6), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: product.id,
                        child: Image.network(
                          product.thumbnail,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                                child: Text(
                              'image not found😢',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ));
                          },
                        ),
                      ),
                    ),
                  ),
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            letterSpacing: 0.5),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$${discountPrice(product.discountPercentage, product.price).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                    ],
                  )
                  // Text(product.title)
                ],
              ),
            )),
        Positioned(
            right: 10,
            top: 5,
            child: Icon(
              Icons.heart_broken,
              color: Colors.red,
            )),
        Positioned(
          right: 5,
          bottom: 100,
          child: Column(
            children: [
              Icon(
                Icons.trending_down,
                color: CupertinoColors.activeGreen,
              ),
              Text(
                '%${product.discountPercentage.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.activeGreen),
              )
            ],
          ),
        )
      ],
    );
  }
}
