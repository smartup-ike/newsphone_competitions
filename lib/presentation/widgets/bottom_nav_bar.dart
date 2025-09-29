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
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width, // fill screen width
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // center items
              children: [
                BottomNavBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/FireSimple.svg',
                    height: 24,
                    width: 24,
                    color: selectedIndex == 0 ? Colors.white : Colors.grey[700],
                  ),
                  label: 'Διαγωνισμοί',
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                BottomNavBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/Lightning.svg',
                    height: 24,
                    width: 24,
                    color: selectedIndex == 1 ? Colors.white : Colors.grey[700],
                  ),
                  label: 'Deals',
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
