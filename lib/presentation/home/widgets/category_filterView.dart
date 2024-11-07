import 'package:flutter/material.dart';

class CategoryFilterView extends StatelessWidget {
  const CategoryFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              'Categories',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )),
            GestureDetector(
              onTap: () async {},
              child: Text('View All'),
            ),
            Icon(Icons.arrow_forward_sharp, size: 20)
          ],
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.network(
                      'https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png'),
                ),
                Text('Beauty')
              ],
            ),
            itemCount: 100,
          ),
        ),
      ],
    );
  }
}
