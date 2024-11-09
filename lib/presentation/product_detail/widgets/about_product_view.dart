import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';

import 'product_dimensions_view.dart';

class AboutProductWidget extends StatelessWidget {
  const AboutProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Brand:',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(product.brand,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))
              ],
            ),
            Row(
              children: [
                Text(
                  'Stock:',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('${product.stock}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))
              ],
            ),
          ],
        ),
        Container(
          height: 80,
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/icons/icons8-warranty-48.png',
                    height: 35,
                    width: 35,
                  ),
                  Text(
                    product.warrantyInformation,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icons/icons8-delivery-50.png',
                    height: 35,
                    width: 35,
                  ),
                  Text(product.shippingInformation,
                      style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icons/icons8-return-40.png',
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                      width: 100,
                      child: Text(product.returnPolicy,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12))),
                ],
              )
            ],
          ),
        ),
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Description',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Additional Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Product Dimensions
            ProductDimensionsView(product: product),
          ],
        ),
      ],
    );
  }
}
