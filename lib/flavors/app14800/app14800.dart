import 'package:flutter/material.dart';

import '../dark_material_theme.dart';

import '../app_colors.dart';
import '../flavor_config.dart';
import 'firebase_options.dart';
import 'terms.dart' as terms;

/// 14800 — channel OPEN (OpenTV).
final FlavorConfig app14800 = FlavorConfig(
  flavorName: 'app14800',
  appId: '14800',
  phoneNumber: '14800',
  appName: '14800',
  stationName: 'OPEN',
  stationNameLatin: 'OPEN',
  notificationsTopic: '14800Notifications',
  appLogoAsset: 'flavors/app14800/bundled/app_logo.png',
  stationLogoAsset: 'flavors/app14800/bundled/station_logo.svg',
  englishTerms: () => terms.englishTerms,
  greekTerms: () => terms.greekTerms,
  // Same Firebase project as 14614 (newphone-test), its own Android/iOS apps.
  // The backend keeps 14800 users and coupons apart via the X-Brand header.
  firebaseOptions: () => App14800FirebaseOptions.currentPlatform,
  materialTheme: () => buildDarkMaterialTheme(app14800.colors),
  poweredByLogoAsset: 'assets/images/smartup-logo light.png',
  stationLogoColor: Colors.white,
  // Dark palette based on tvopen.gr (#151515 / #232323, white text, #CC5500).
  // Approved 2026-11-17. If a final brand palette arrives, update the values here.
  colors: const AppColors(
    // Brand
    primary: Color(0xFFCC5500),
    primary10: Color(0xFFD96E1F),
    primary20: Color(0xFFFF7A1A),
    primary30: Color(0xFF7A3A10),
    primary40: Color(0xFF4A2A14),
    primary50: Color(0xFF3A2414),
    primary60: Color(0xFF2E1E14),
    primary70: Color(0xFF2A1C14),
    primary80: Color(0xFF261A13),
    primary90: Color(0xFF221812),
    primaryDark: Color(0xFFFF9A4D),
    selectedTint: Color(0xFF3A2414),
    gradientStart: Color(0xFFF9A11B),
    gradientEnd: Color(0xFFEF4E23),
    gradientAccent: Color(0xFFF7941D),
    appBarLogoBackground: Color(0xFF232323),
    dealGradientStart: Color(0xFFCC5500),
    dealGradientEnd: Color(0xFFEA3514),
    dealGlow: Color(0xFFEF4E23),
    successTintEdge: Color(0xFF2A1D14),
    successTintMid: Color(0xFF33221A),
    switchActive: Color(0xFFCC5500),
    resendAction: Color(0xFFFF9A4D),
    link: Color(0xFFFF9A4D),
    // Backgrounds
    scaffold: Color(0xFF151515),
    scaffoldMuted: Color(0xFF151515),
    surface: Color(0xFF232323),
    surfaceMuted: Color(0xFF2C2C2C),
    surfaceSubtle: Color(0xFF2C2C2C),
    buttonDisabled: Color(0x33FFFFFF),
    disabledFill: Color(0xFF3A3A3A),
    imagePlaceholder: Color(0xFF2C2C2C),
    imagePlaceholderStrong: Color(0xFF2C2C2C),
    // Lines
    divider: Color(0xFF333333),
    dividerMuted: Color(0xFF4A4A4A),
    separator: Color(0xFF3A3A3A),
    navBarBorder: Color(0x14FFFFFF),
    outline: Color(0xFF5A5A5A),
    outlineMuted: Color(0xFF666666),
    outlineLight: Color(0xFF555555),
    inputBorder: Color(0xFF666666),
    shadow: Color(0xFF000000),
    shadowSoft: Color(0xFF000000),
    // Text
    textPrimary: Color(0xFFEDEDED),
    textStrong: Color(0xFFFFFFFF),
    textHeading: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB3B3B3),
    textTertiary: Color(0xFF9E9E9E),
    textMuted: Color(0xFFA6A6A6),
    textDisabled: Color(0xFF6E6E6E),
    textFaint: Color(0xFF8A8A8A),
    contrast: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    onImagePlaceholder: Color(0xFF6E6E6E),
    // Icons
    iconMuted: Color(0xFF8A8A8A),
    navIconInactive: Color(0xFFA6A6A6),
    indicatorInactive: Color(0xFF555555),
    // States
    danger: Color(0xFFEA3514),
    emphasis: Color(0xFFFF5A3C),
    activeState: Color(0xFF2ECC71),
    success: Color(0xFF2E9E4F),
    error: Color(0xFFEA3514),
    errorText: Color(0xFFFF6B5A),
  ),
);
