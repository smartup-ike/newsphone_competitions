import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      height: 81,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomNavBarItem(
              icon: SvgPicture.asset(
                'assets/images/icons/FireSimple.svg',
                height: 24.0,
                width: 24.0,
                color: selectedIndex == 0 ? Colors.white : Colors.grey[700],
              ),
              label: 'Διαγωνισμοί',
              isSelected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            BottomNavBarItem(
              icon: SvgPicture.asset(
                'assets/images/icons/Lightning.svg',
                height: 24.0,
                width: 24.0,
                color: selectedIndex == 0 ? Colors.grey[700] : Colors.white,
              ),
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
