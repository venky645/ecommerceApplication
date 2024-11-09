import 'package:flutter/material.dart';

import '../../../model/product.dart';

class ProductDimensionsView extends StatelessWidget {
  final Product product;
  const ProductDimensionsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dimensions:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text('Width: ${product.dimension?['width']} cm'),
        Text('Height: ${product.dimension?['height']} cm'),
        Text('Depth: ${product.dimension?['depth']} cm'),
      ],
    );
  }
}
