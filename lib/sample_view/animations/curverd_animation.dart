import 'package:flutter/material.dart';

class CurvedAnimationExample extends StatefulWidget {
  @override
  _CurvedAnimationExampleState createState() => _CurvedAnimationExampleState();
}

class _CurvedAnimationExampleState extends State<CurvedAnimationExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Use a CurvedAnimation to add some bounce effect
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn, // Smooth movement left to right
    );

    _controller.repeat(reverse: true); // Repeat the animation in both directions
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    return
      Scaffold(
        appBar: AppBar(title: Text("Transform Animation")),
        body: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..translate(_animation.value * 100, 0) // Horizontal translation
                  ..rotateZ(_animation.value * 2 ), // Rotation
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ),
      );
  }
}
