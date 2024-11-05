import 'package:flutter/material.dart';

class ExplicitAnimationExample extends StatefulWidget {
  const ExplicitAnimationExample({super.key});

  @override
  _ExplicitAnimationExampleState createState() => _ExplicitAnimationExampleState();
}

class _ExplicitAnimationExampleState extends State<ExplicitAnimationExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), vsync: this,
      // vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explicit Animation")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
            height: _animation.value,
              width: _animation.value,
              color: Colors.green,
            );
          },

        ),
      ),
    );
  }
}
