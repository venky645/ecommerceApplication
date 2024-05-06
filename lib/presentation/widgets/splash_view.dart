import 'dart:async';

import 'package:ecommerce_app/presentation/widgets/AuthenticationHandler.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState()  {
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AuthenticationHandler()));    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome',style: TextStyle(fontSize: 25),),
            Text('splash')
          ],
        ),
      ),
    );
  }
}
