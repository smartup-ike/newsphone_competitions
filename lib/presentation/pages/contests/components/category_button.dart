import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;
  final bool? isFirst;
  final bool? isLast;

  const CategoryButton({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.isFirst,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isFirst == true ? 4 : 0,
        right: isLast == true ? 4 : 0,
        top: 5,
        bottom: 5,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              gradient:
                  isSelected
                      ? LinearGradient(
                        colors: [
                          NewsphoneTheme.primary20,
                          NewsphoneTheme.primary20,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                      : null,
              color: isSelected ? null : Colors.transparent,
              // fallback for unselected
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Text(
              category,
              style: TextStyle(
                color:
                    isSelected
                        ? NewsphoneTheme.neutralWhite
                        : NewsphoneTheme.neutral30,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
