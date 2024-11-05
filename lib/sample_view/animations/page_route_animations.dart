import 'package:flutter/material.dart';

class PageRouteAnimationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return SecondPage();
                },
              transitionDuration: Duration(seconds: 5),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation,child: child,),

            ));
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: Text("Second Page"),
      ),
    );
  }
}
