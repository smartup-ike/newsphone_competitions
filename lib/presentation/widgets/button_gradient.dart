import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonGradient extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const ButtonGradient({
    super.key,
    required this.title,
    required this.colors,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.robotoFlex(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 20 / 13,
      letterSpacing: -0.13,
    );

    // Measure the height needed for the text
    final textHeight = (textStyle.fontSize ?? 14) * (textStyle.height ?? 1.0);

    // Add vertical padding for the button
    final verticalPadding = 12.0;

    final buttonHeight = textHeight + verticalPadding * 2;

    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isDisabled
            ? null
            : LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        color: isDisabled ? Colors.black12 : null,
      ),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
