import 'package:flutter/material.dart';
import 'bottom_nav_bar_item.dart';

class HomePageBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const HomePageBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomNavBarItem(
              icon: Icons.emoji_events,
              label: 'Διαγωνισμοί',
              isSelected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            BottomNavBarItem(
              icon: Icons.local_offer,
              label: 'Deals',
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
