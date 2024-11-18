import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/cubit/product_detail_cubit.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/app_bar.dart';
import 'package:ecommerce_app/presentation/product_detail/widgets/product_detail_thumbnail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/remote/firestore_db.dart';
import 'widgets/product_detail_bottom_sheet.dart';
import 'widgets/tab_bar_view.dart';
import 'widgets/title_and_rating_overview_section.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  int? productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productId = ModalRoute.of(context)!.settings.arguments as int;
    _productDetailsFetch();
  }

  Future<void> _productDetailsFetch() async {
    if (productId != null) {
      Product? product = await FireStoreDataBase.instance
          ?.getProductById(productId.toString());

      if (mounted) {
        context
            .read<ProductDetailCubit>()
            .checkingProductStatus(productId.toString());
        context
            .read<ProductDetailCubit>()
            .updateProductThumbnail(product!.thumbnail);
        context
            .read<ProductDetailBloc>()
            .add(FetchProduct(productId: productId.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          print('successfully poped');
          // BlocProvider.of<CartBloc>(context).add(AddProductToCart());
        } else {
          print('un-successfull poped');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xF5F9F9F5),
        appBar: const AppBarView(),
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
                          ProductDetailThumbNailVew(product: state.product),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleAndRatingOverViewSection(
                                    product: state.product),
                                SizedBox(height: 15),
                                TabBarWidget(product: state.product)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProductDetailBottomSheetView(
                    product: state.product,
                  )
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
}
