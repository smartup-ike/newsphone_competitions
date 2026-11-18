import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';
import '../flavor_config.dart';
import 'firebase_options.dart';
import 'terms.dart' as terms;

/// 14614 — channel ANT1.
/// IMPORTANT: this app must stay exactly as it was before flavors.
/// Every value here equals the value that was hard-coded before.
final FlavorConfig app14614 = FlavorConfig(
  flavorName: 'app14614',
  appId: '14614',
  phoneNumber: '14614',
  appName: '14614',
  stationName: 'ΑΝΤ1',
  stationNameLatin: 'ANT1',
  notificationsTopic: '14614Notifications',
  appLogoAsset: 'flavors/app14614/bundled/app_logo.png',
  stationLogoAsset: 'flavors/app14614/bundled/station_logo.png',
  englishTerms: () => terms.englishTerms,
  greekTerms: () => terms.greekTerms,
  firebaseOptions: () => App14614FirebaseOptions.currentPlatform,
  materialTheme: () => ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
  poweredByLogoAsset: 'assets/images/smartup.png',
  colors: const AppColors(
    // Brand
    primary: Color(0xFF0072BC),
    primary10: Color(0xFF3393D1),
    primary20: Color(0xFF07BCEF),
    primary30: Color(0xFF99CDED),
    primary40: Color(0xFFCCE5F6),
    primary50: Color(0xFFE6F2FA),
    primary60: Color(0xFFF2F8FD),
    primary70: Color(0xFFF8FBFE),
    primary80: Color(0xFFFBFCFE),
    primary90: Color(0xFFFEFEFF),
    primaryDark: Color(0xFF054279),
    selectedTint: Color(0xFFE0F0FF),
    gradientStart: Color(0xFFE082FF),
    gradientEnd: Color(0xFF0765CB),
    gradientAccent: Color(0xFF08C7F4),
    appBarLogoBackground: Color(0xFF0072BC),
    dealGradientStart: Color(0xFF0072BC),
    dealGradientEnd: Color(0xFFED1953),
    dealGlow: Color(0xFF5A44E0),
    successTintEdge: Color(0xFFECFEFF),
    successTintMid: Color(0xFFEFF6FF),
    switchActive: Color(0xFF2196F3),
    resendAction: Color(0xFF3B5998),
    link: Color(0xFF2AB2FF),
    // Backgrounds
    scaffold: Color(0xFFFFFFFF),
    scaffoldMuted: Color(0xFFF2F4F7),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF2F4F7),
    surfaceSubtle: Color(0xFFE7E9EB),
    buttonDisabled: Color(0x1F000000),
    disabledFill: Color(0xFFE0E0E0),
    imagePlaceholder: Color(0xFFE0E0E0),
    imagePlaceholderStrong: Color(0xFF555758),
    // Lines
    divider: Color(0xFFE0E0E0),
    dividerMuted: Color(0xFFA4A7AA),
    separator: Color(0xFF555758),
    navBarBorder: Color(0x1F000000),
    outline: Color(0xFF9E9E9E),
    outlineMuted: Color(0xFF989B9F),
    outlineLight: Color(0xFFC1C2C6),
    inputBorder: Color(0xFF555758),
    shadow: Color(0xFF000000),
    shadowSoft: Color(0xFF9E9E9E),
    // Text
    textPrimary: Color(0xFF333435),
    textStrong: Color(0xFF0C0C0C),
    textHeading: Color(0xFF222223),
    textSecondary: Color(0xFF555758),
    textTertiary: Color(0xFF777A7C),
    textMuted: Color(0xFF6F7582),
    textDisabled: Color(0xFF9E9E9E),
    textFaint: Color(0xFF757575),
    contrast: Color(0xFF000000),
    onPrimary: Color(0xFFFFFFFF),
    onImagePlaceholder: Color(0xFFFFFFFF),
    // Icons
    iconMuted: Color(0xFF9E9E9E),
    navIconInactive: Color(0xFF616161),
    indicatorInactive: Color(0xFFBDBDBD),
    // States
    danger: Color(0xFFED1953),
    emphasis: Color(0xFFED1953),
    activeState: Color(0xFF00A113),
    success: Color(0xFF1D8E3D),
    error: Color(0xFFE72121),
    errorText: Color(0xFFF44336),
  ),
);
