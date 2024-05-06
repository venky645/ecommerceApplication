import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthenticationHandler extends StatelessWidget {
   AuthenticationHandler({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: Future.value(_auth.currentUser),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return null when waiting
            return SizedBox.shrink();
          } else {
            if (snapshot.hasData) {
              Navigator.pushNamed(context, '/home');
            } else {
              Navigator.pushNamed(context, '/login');
            }
            // Return a default widget in case none of the conditions are met
            return SizedBox.shrink(); // or Container()
          }
        }
    );
  }

}



