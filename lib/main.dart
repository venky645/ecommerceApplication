import 'package:ecommerce_app/presentation/auth_screens/sign_upView.dart';
import 'package:ecommerce_app/presentation/home/home_view.dart';
import 'package:ecommerce_app/presentation/widgets/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_view.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options:
   const FirebaseOptions(
       apiKey: 'AIzaSyChPxyEjqETSdA1Fv4uPcmEIBXWTtVeuyE',
       appId: '1:975692327233:android:859c8af699548e669cd9c0',
       messagingSenderId: '975692327233',
       projectId: 'ecommerceapp-c6107')
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashView(),
        '/signup': (context) =>  SignUpView(),
        '/login' : (context) => LoginView(),
        '/home':(context) => HomeView()
      },
    );
  }
}

