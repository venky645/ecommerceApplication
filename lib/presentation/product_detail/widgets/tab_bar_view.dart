import 'package:ecommerce_app/presentation/product_detail/widgets/about_product_view.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/review_section.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key, required this.product});
  final Product product;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabbar = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _selectedTabbar = index;
              });
            },
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black54,
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Reviews'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _selectedTabbar == 0
            ? AboutProductWidget(product: widget.product)
            : ReviewsSection(
                reviews: widget.product.reviews,
                productId: widget.product.id.toString())
      ],
    );
  }
}
