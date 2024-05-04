import 'package:academy_course/presentation/login_view.dart';
import 'package:academy_course/presentation/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  const FirebaseOptions(
      apiKey: 'AIzaSyC_LJWakz_Ah7tY3P1mTe_Ay36SLKg9AEw',
      appId: '1:183402312874:android:f6778f1450dd1ec496ccd3',
      messagingSenderId: '183402312874',
      projectId: 'ecommerceassaignment')
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>const LoginView(),
        '/products' :(context) => const ProductsView()
      },
    );
  }
}
