import 'package:flutter/material.dart';

class SecondScreenForAnimations extends StatelessWidget {
  const SecondScreenForAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'hero_tag',
        child: Image.network('https://www.startech.com.bd/image/cache/catalog/blog/2023/apple-iphone-15-leak/apple-iphone-15-leak-banner-740x350.jpg',
        errorBuilder:
          (context, error, stackTrace) => Text('unable to load'),),
      ),
    );
  }
}
