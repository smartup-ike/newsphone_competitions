import 'package:flutter/material.dart';

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
        color: isSelected ? Color(0xFF004079) : Colors.black87,
      ),
      avatar:
          isSelected
              ? const Icon(Icons.check, color: Color(0xFF004079), size: 16)
              : null,
      side: BorderSide(color: isSelected ? Color(0xFF004079) : Colors.grey),
      backgroundColor: isSelected ? Color(0XFFDEF8FF) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: onPressed,
    );
  }
}