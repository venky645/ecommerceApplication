import 'package:flutter/material.dart';
import '../../widgets/cart_badge.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xF5F9F9F5),
      actions: const [
        Icon(
          Icons.heart_broken_rounded,
          color: Colors.red,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.share_outlined),
        SizedBox(
          width: 20,
        ),
        CartWithBadge(),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
