import 'dart:ui';

import 'package:ecommerce_app/utils/SecondScreenFOrFLutterAnimations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlutterAnimationView extends StatefulWidget {
  const FlutterAnimationView({super.key});

  @override
  State<FlutterAnimationView> createState() => _FlutterAnimationViewState();
}

class _FlutterAnimationViewState extends State<FlutterAnimationView> {

  double _width  = 200;
  Color _color   = Colors.blue;
  double margin  = 0;
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             AnimatedContainer(
               duration:Duration(seconds: 3),
               width: _width,
               margin: EdgeInsets.zero,
               color: _color,

               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(
                       onPressed: () {
                         setState(() {
                           _color = _color == Colors.blue?Colors.red:Colors.blue;
                           _width = _width==100?400:100;
                         });
                       }, child: Text('change color')
                   ),
                   ElevatedButton(
                       onPressed: () {
                         setState(() {
                           opacity = opacity == 0 ? 1 : 0;

                         });
                       }, child: Text('hide name')
                   ),
                   AnimatedOpacity(
                     opacity: opacity, duration: Duration(seconds: 2),
                     child: const Text('i am venky'),

                   ),
                   TweenAnimationBuilder(
                       tween: Tween<double>(begin: 0,end: 1),
                       duration: Duration(seconds: 3),
                       builder: (context, value, child) => Opacity(opacity: value,
                       child: Text('hello'),) ,
                   ),

                 ],
               ),
             ),
             GestureDetector(
               onTap: () {
                 Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const SecondScreenForAnimations()),                 );
               },
               child: Hero(
                 tag: 'hero_tag',
                 child: Image.network(
                   'https://www.startech.com.bd/image/cache/catalog/blog/2023/apple-iphone-15-leak/apple-iphone-15-leak-banner-740x350.jpg',
                   width: 100,
                   errorBuilder: (context, error, stackTrace) => Text('uble to load image'),

                 ),
               ),
             )
           ],
         ),
       ),
    );
  }
}
