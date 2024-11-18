import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_event.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_state.dart';
import 'package:ecommerce_app/presentation/home/widgets/page_view.dart';
import 'package:ecommerce_app/presentation/home/widgets/product_view.dart';
import 'package:ecommerce_app/presentation/home/widgets/search_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../widgets/bloc_global_access_testing.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/cart_badge.dart';
import 'widgets/category_filterView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products = [];
  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    loadAllTheProducts();
    paymentIntegrationByRazor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadAllTheProducts() async {
    context.read<HomeBloc>().add(FetchAllProducts());
    // context.read<CartBloc>().add(AddProductToCart());
  }

  void paymentIntegrationByRazor() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xF5F9F9F5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Hello, ${FirebaseAuthService().getUserDetails().then((value) {
                            value!.email;
                          })}',
                          style: TextStyle(color: Colors.grey)),
                      GestureDetector(
                        onTap: () async {
                          var options = {
                            'key': 'rzp_live_ILgsfZCZoFIKMb',
                            'amount': 100,
                            'name': 'Acme Corp.',
                            'description': 'Fine T-Shirt',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '8888888888',
                              'email': 'test@razorpay.com'
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };

                          razorpay.open(options);
                        },
                        child: const Text('Welcome',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const CartWithBadge()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SearchBarView(),
                  Container(
                    height: 30,
                    child:
                        Icon(CupertinoIcons.arrow_right_arrow_left_square_fill),
                  )
                ],
              ),
              const SizedBox(height: 30),
              const CategoryFilterView(),
              SizedBox(height: 5),
              Stack(children: [
                SizedBox(
                  height: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const PageViewWidget()),
                ),
              ]),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is ProductsSuccess) {
                      products = state.products;
                    } else if (state is ProductsError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductCardView(product: products[index]),
                          onTap: () {
                            Navigator.pushNamed(context, '/productDetailView',
                                arguments: products[index].id);
                          },
                        );
                      },
                      itemCount: products.length,
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationBarView());
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
