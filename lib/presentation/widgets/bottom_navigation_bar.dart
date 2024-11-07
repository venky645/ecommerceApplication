import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
      selectedIconTheme: IconThemeData(
        color: Colors.green,
        size: 24,
      ),
      showUnselectedLabels: true,
      onTap: (value) {
        switch (value) {
          case 3:
            Navigator.pushNamed(context, '/profile');
          default:
            print('selection not valid');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
            color: Colors.green,
            size: 40,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.black, size: 40),
          label: 'search',
        ),
        BottomNavigationBarItem(
            icon:
                Icon(Icons.heart_broken_rounded, color: Colors.black, size: 40),
            label: 'favourites'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black, size: 40),
            label: 'Profile')
      ],
    );
  }
}
