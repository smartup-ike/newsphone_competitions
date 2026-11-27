import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

class ProgramButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ProgramButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: selected ? NewsphoneTheme.selectedTint : NewsphoneTheme.surface,
          // light blue when selected
          border: Border.all(color: NewsphoneTheme.primaryDark, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Outer Circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: NewsphoneTheme.primaryDark, width: 1.6),
              ),
              child: Center(
                // Inner dot
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        selected ? NewsphoneTheme.primaryDark : Colors.transparent,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Text
            Text(
              label,
              style: TextStyle(
                color: NewsphoneTheme.primaryDark,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
