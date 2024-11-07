import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        leading: Icon(
          icon,
          color: Color.fromARGB(255, 7, 134, 237),
          size: 25,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color.fromARGB(255, 7, 134, 237),
        ),
      ),
    );
  }
}
