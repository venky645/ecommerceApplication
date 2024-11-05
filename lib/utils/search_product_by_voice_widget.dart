import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSearchByVoice extends StatefulWidget {
  const ProductSearchByVoice({super.key});

  @override
  State<ProductSearchByVoice> createState() => _ProductSearchByVoiceState();
}

class _ProductSearchByVoiceState extends State<ProductSearchByVoice> {
  double _width = 200;
  @override
  void initState() {
    _width = 400;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 200,end: 500),
        duration: Duration(seconds: 3),
        builder: (context, value, child) =>
            Container(
              width: value,
              height: value,
              color: Colors.red,
              child:  Container(
                height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),

              child: Icon(Icons.mic,color: Colors.white,size: 30,)
                      ),
            )
      )
    );
  }
}
