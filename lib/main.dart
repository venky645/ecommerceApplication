import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_bloc.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_upView.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/presentation/home/home_view.dart';
import 'package:ecommerce_app/presentation/my_cart_view/MyCartView.dart';
import 'package:ecommerce_app/presentation/my_cart_view/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/cubit/product_detail_cubit.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:ecommerce_app/presentation/product_detail/product_detail_view.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_cubit.dart';
import 'package:ecommerce_app/presentation/profile_view/profile_view.dart';
import 'package:ecommerce_app/presentation/widgets/splash_view.dart';
import 'package:ecommerce_app/sample_view/counter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/auth_screens/sign_up_bloc/sign_up_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyChPxyEjqETSdA1Fv4uPcmEIBXWTtVeuyE',
          appId: '1:975692327233:android:859c8af699548e669cd9c0',
          messagingSenderId: '975692327233',
          projectId: 'ecommerceapp-c6107'));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProductDetailCubit>(
            create: (context) => ProductDetailCubit()),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashView(),
          '/signup': (context) => const SignUpView(),
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomeView(),
          '/productDetailView': (context) => ProductDetailView(),
          '/myCart': (context) => const MyCartView(),
          '/profile': (context) => const ProfileView()
        },
      ),
    );
  }
}
