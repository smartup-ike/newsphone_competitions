import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade700,
    inverseSurface: Colors.grey.shade900,
    secondaryContainer: Colors.white,
    shadow: Colors.grey,
  ),
  textTheme: GoogleFonts.robotoFlexTextTheme(
    ThemeData.light().textTheme,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, // Opposite of light surface (grey.shade300)
    primary: Colors.grey.shade800, // Opposite of light primary (grey.shade200)
    secondary: Colors.black,     // Opposite of light secondary (white)
    inversePrimary: Colors.grey.shade300, // Opposite of light inversePrimary (grey.shade700)
    inverseSurface: Colors.grey.shade300,
    secondaryContainer: Colors.grey.shade800,
    shadow: Colors.grey.shade900,
    // Opposite of light inverseSurface (grey.shade900)
  ),
);