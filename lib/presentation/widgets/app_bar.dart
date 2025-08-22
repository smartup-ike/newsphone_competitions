import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback clickNotificationFunction;
  final VoidCallback clickDrawerFunction;

  const HomePageAppBar({
    super.key,
    required this.clickNotificationFunction,
    required this.clickDrawerFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 27, width: 93),
          const SizedBox(width: 8),
          Image.asset('assets/images/frame.png', height: 30, width: 118),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.bell, color: Colors.black),
          onPressed: clickNotificationFunction,
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: clickDrawerFunction,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
