import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Material theme for dark apps (e.g. 14800). It only sets Flutter's
/// *defaults* (sheets, dialogs, menus, plain text, inputs, progress
/// indicators); every screen still takes its colors from [AppColors].
ThemeData buildDarkMaterialTheme(AppColors c) {
  final base = ThemeData(brightness: Brightness.dark);
  return base.copyWith(
    textTheme: GoogleFonts.robotoTextTheme(base.textTheme).apply(
      bodyColor: c.textPrimary,
      displayColor: c.textPrimary,
    ),
    scaffoldBackgroundColor: c.scaffold,
    canvasColor: c.surface,
    cardColor: c.surface,
    dividerColor: c.divider,
    colorScheme: ColorScheme.dark(
      primary: c.primary,
      onPrimary: c.onPrimary,
      secondary: c.primary20,
      onSecondary: c.onPrimary,
      surface: c.surface,
      onSurface: c.textPrimary,
      error: c.error,
      onError: c.onPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: c.surface,
      foregroundColor: c.textStrong,
      surfaceTintColor: Colors.transparent,
    ),
    iconTheme: IconThemeData(color: c.textStrong),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: c.surface,
      modalBackgroundColor: c.surface,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: c.surface,
      surfaceTintColor: Colors.transparent,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: c.surface,
      surfaceTintColor: Colors.transparent,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: c.surfaceMuted,
      contentTextStyle: TextStyle(color: c.textPrimary),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: c.primary),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: c.primary,
      selectionHandleColor: c.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: c.textTertiary),
      labelStyle: TextStyle(color: c.textSecondary),
    ),
  );
}
