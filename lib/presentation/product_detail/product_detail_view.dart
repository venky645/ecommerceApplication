

import 'package:ecommerce_app/db/local/data_base_helper.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/cubit/product_detail_cubit.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/add_to_cart_view.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/review_section.dart';
import 'package:ecommerce_app/presentation/widgets/cart_badge.dart';
import 'package:ecommerce_app/utils/discount_calculation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailView extends StatefulWidget {
  ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  int? productId;
  late TabController _tabController;
  int _selectedTabbar = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productId = ModalRoute.of(context)!.settings.arguments as int;
    if (productId != null) {
      BlocProvider.of<ProductDetailCubit>(context)
          .checkingProductStatus('${productId}');
      BlocProvider.of<ProductDetailCubit>(context)
          .updateProductThumbnail('${productId}');
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductDetailBloc>(context)
        .add(FetchProduct(productId: '${productId}'));
    // context.read<CartBloc>().add(CartCount)
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          print('successfully poped');
          BlocProvider.of<CartBloc>(context).add(AddProductToCart());
        } else {
          print('un-successfull poped');
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xF5F9F9F5),
        appBar: AppBar(
          backgroundColor: const Color(0xF5F9F9F5),
          actions: [
            Icon(
              Icons.heart_broken_rounded,
              color: Colors.red,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.share_outlined),
            SizedBox(
              width: 20,
            ),
            CartWithBadge(),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: BlocConsumer<ProductDetailBloc, ProductDetailBlocState>(
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              current is ProductFetchSuccess || current is ProductFetchFailure,
          builder: (context, state) {
            if (state is ProductFetchSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<ProductDetailCubit, ProductDetailState>(
                              builder: (context, cubitState) => Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                    2 -
                                                AppBar().preferredSize.height,
                                        decoration: BoxDecoration(),
                                        child: Hero(
                                          tag: state.product.id,
                                          child: Image.network(
                                              cubitState.productThumbnail,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      state.product.images!.length > 1
                                          ? Positioned(
                                              top: 0,
                                              left: -5,
                                              child: Container(
                                                height: 300,
                                                width: 100,
                                                child: ListView.builder(
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      ProductDetailCubit>(
                                                                  context)
                                                              .updateProductThumbnail(
                                                                  state.product
                                                                          .images?[
                                                                      index]);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 40,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          16))),
                                                          child: Image.network(
                                                            state.product
                                                                .images?[index],
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            height: 100,
                                                            width: 100,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount: state.product
                                                        .images?.length),
                                              ))
                                          : const SizedBox()
                                    ],
                                  )),
                          Container(
                            width: double.infinity,
                            // margin: EdgeInsets.only(bottom: 100),
                            padding:
                                EdgeInsets.only(left: 20, top: 15, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.product.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          Text(
                                              '${state.product.rating.toStringAsFixed(1)} Ratings',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      BlocBuilder<ProductDetailBloc,
                                          ProductDetailBlocState>(
                                        builder: (context, state) {
                                          if (state is ProductReviews) {
                                            return Text(
                                                '${state.reviews.length}+ Reviews',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15));
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Column(
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
                                        labelStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        unselectedLabelColor: Colors.black54,
                                        tabs: [
                                          Tab(text: 'About'),
                                          Tab(text: 'Reviews'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _selectedTabbar == 0
                                        ? aboutProduct(state.product)
                                        : ReviewsSection(
                                            reviews: state.product.reviews,
                                            productId: '${state.product.id}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.grey.shade300)),
                        boxShadow: [BoxShadow(color: Colors.grey)]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_down,
                                      color: CupertinoColors.activeGreen,
                                    ),
                                    Text(
                                      '%${state.product.discountPercentage.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoColors.activeGreen),
                                    )
                                  ],
                                ),
                                Text(
                                  '\$${state.product.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '\$${discountPrice(state.product.discountPercentage, state.product.price).toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        AddToCartView(
                          productId: '${state.product.id}',
                          addProductToCart: () {
                            addProductToCart(state.product);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              print('failure');
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  void addProductToCart(Product product) async {
    try {
      Cart cartItem = Cart(
          id: product.id,
          title: product.title,
          thumbnail: product.thumbnail,
          price: product.price as double,
          quantity: 1,
          brand: product.brand,
          discountPercentage: product.discountPercentage as double);

      int productID = await DataBaseHelper().insertItem(cartItem.toJson());
      if (productID != 0) {
        if (mounted) {
          context.read<ProductDetailCubit>().addItemToCart();
          // BlocProvider.of<ProductDetailCubit>(context).addItemToCart();
          context.read<CartBloc>().add(AddProductToCart());
          // BlocProvider.of<CartBloc>(context).add(AddProductToCart());
        }
      } else {
        print('ahcbwoooooooooooooo:   $productID');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget aboutProduct(Product product) {
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
                  Text(product!.shippingInformation,
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
                      child: Text(product!.returnPolicy,
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
              product!.description,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dimensions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text('Width: ${product?.dimension?['width']} cm'),
                Text('Height: ${product?.dimension?['height']} cm'),
                Text('Depth: ${product?.dimension?['depth']} cm'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
