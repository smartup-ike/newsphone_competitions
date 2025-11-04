import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

// Reusable widget for a selectable category chip
class CustomActionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomActionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      labelStyle: TextStyle(
        color:
            isSelected ? NewsphoneTheme.primary : NewsphoneTheme.neutralBlack,
      ),
      avatar:
          isSelected
              ? Icon(Icons.check, color: NewsphoneTheme.primary, size: 16)
              : null,
      side: BorderSide(
        color: isSelected ? NewsphoneTheme.primary : NewsphoneTheme.neutral50,
      ),
      backgroundColor:
          isSelected ? NewsphoneTheme.primary40 : NewsphoneTheme.neutralWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: onPressed,
    );
  }
}
