import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/pagination_provider.dart';
import '../constants/constants.dart';
import '../mediaQuery/mediaquery_helper.dart';
import '../presentation/widgets/product_card.dart';
import '../provider/api_provider.dart';
import 'widgets/pagination_view.dart';

class ProductsView extends ConsumerStatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  final int _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final products = [];
    final pageNumber = ref.watch(paginationProvider);

    final startIndex = (pageNumber - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;

    final currentPageProducts = [];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F4),
      appBar: AppBar(
        title: const Text(Constants.products),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQueryHelper.responsiveValue(context, 20),
              vertical: mediaQueryHelper.responsiveValue(context, 10),
            ),
            child: Text(
              'Showing $startIndex - $endIndex Products',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = currentPageProducts?[index];
                if (product != null) {
                  return ProductCard(product: product);
                } else {
                  return const SizedBox();
                }
              },
              itemCount: currentPageProducts?.length ?? 0,
            ),
          ),
          const PaginationView(),
        ],
      ),
    );
  }
}
