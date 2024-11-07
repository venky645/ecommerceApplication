import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/api_provider.dart';
import '../../provider/pagination_provider.dart';

class PaginationView extends ConsumerWidget {
  const PaginationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNumber = ref.watch(paginationProvider);
    // final products = ref.watch(productsProvider);
    // Checking whether products are available on the next page or not
    // final hasNextPage = _hasNextPage(pageNumber, products.value?.length);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: pageNumber > 1
                ? () => ref.read(paginationProvider.notifier).decrementPage()
                : null,
          ),
          Text(
            'Page $pageNumber',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
            // hasNextPage
            //     ? () => ref.read(paginationProvider.notifier).increment()
            //     : null,
          ),
        ],
      ),
    );
  }

  bool _hasNextPage(int currentPage, int? totalProducts) {
    if (totalProducts == null) return false;
    final pageSize = 10;
    final startIndex = (currentPage - 1) * pageSize;
    return (startIndex + pageSize) < totalProducts;
  }
}
