import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 320,
      child: TextField(
        controller: null,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(
              Icons.mic,
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }
}
