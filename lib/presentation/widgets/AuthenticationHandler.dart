import 'package:ecommerce_app/presentation/auth_screens/login_view.dart';
import 'package:ecommerce_app/presentation/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationHandler extends StatelessWidget {
  const AuthenticationHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          print('used loggedIN');
          User? user = FirebaseAuth.instance.currentUser;
          print('$user');
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? const HomeView() : const LoginView();
        }
      },
    );
  }
}
