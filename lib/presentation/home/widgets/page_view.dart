import 'dart:async';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late Timer _timer;
  int _currentPage = 0;
  final _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    pageViewAnimation();
    super.initState();
  }

  void pageViewAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (int pageNumber) {
        print(pageNumber);
      },
      controller: _pageController,
      children: [
        Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
            fit: BoxFit.fill, errorBuilder: (BuildContext context,
                Object exception, StackTrace? stackTrace) {
          return Center(child: Text('Failed to load image : $exception'));
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
              fit: BoxFit.fill, errorBuilder: (BuildContext context,
                  Object exception, StackTrace? stackTrace) {
            return Center(child: Text('Failed to load image : $exception'));
          }),
        ),
        Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHbNZse3Rc6r8fq0wbmr_84jzwfwvAg06dKQ&s',
            fit: BoxFit.fill, errorBuilder: (BuildContext context,
                Object exception, StackTrace? stackTrace) {
          return Center(child: Text('Failed to load image : $exception'));
        }),
      ],
    );
  }
}
