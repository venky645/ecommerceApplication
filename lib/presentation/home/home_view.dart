import 'dart:async';
import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_event.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_state.dart';
import 'package:ecommerce_app/presentation/home/widgets/product_view.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_event.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../widgets/cart_badge.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products = [];
  late Timer _timer;
  int _currentPage = 0;
  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    pageViewAnimation();
    loadAllTheProducts();
    paymentIntegrationByRazor();
  }

  void pageViewAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  final _pageController = PageController(
    initialPage: 0,
  );

  void loadAllTheProducts() async {
    context.read<HomeBloc>().add(FetchAllProducts());
    context.read<CartBloc>().add(AddProductToCart());
  }

  void paymentIntegrationByRazor() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF5F9F9F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
                        print('loading......');
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
                      child: Text('Welcome',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                CartWithBadge()
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 320,
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.mic,
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
                Container(
                  height: 30,
                  child:
                      Icon(CupertinoIcons.arrow_right_arrow_left_square_fill),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
                GestureDetector(
                  onTap: () async {},
                  child: Text('View All'),
                ),
                Icon(Icons.arrow_forward_sharp, size: 20)
              ],
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.network(
                          'https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png'),
                    ),
                    Text('Beauty')
                  ],
                ),
                itemCount: 100,
              ),
            ),
            SizedBox(height: 5),
            Stack(children: [
              SizedBox(
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: PageView(
                    onPageChanged: (int pageNumber) {
                      print(pageNumber);
                    },
                    controller: _pageController,
                    children: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
                          fit: BoxFit.fill, errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                        return Center(
                            child: Text('Failed to load image : $exception'));
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
                            fit: BoxFit.fill, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                          return Center(
                              child: Text('Failed to load image : $exception'));
                        }),
                      ),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
                          fit: BoxFit.fill, errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                        return Center(
                            child: Text('Failed to load image : $exception'));
                      }),
                    ],
                  ),
                ),
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
                    itemCount: products.length ?? 0,
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
        selectedIconTheme: IconThemeData(
          color: Colors.green,
          size: 24,
        ),
        showUnselectedLabels: true,
        onTap: (value) {
          switch (value) {
            case 3:
              Navigator.pushNamed(context, '/profile');
            default:
              print('selection not valid');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.green,
              size: 40,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black, size: 40),
            label: 'search',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken_rounded,
                  color: Colors.black, size: 40),
              label: 'favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black, size: 40),
              label: 'Profile')
        ],
      ),
    );
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
    Widget continueButton = ElevatedButton(
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
