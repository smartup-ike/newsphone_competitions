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
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.robotoFlex(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 22 / 13,
            letterSpacing: -0.13,
          ),
        ),
      ),
    );
  }
}
