// 14614 must look exactly as it did before flavors. These are the colors
// that were hard-coded in the screens before; if one fails, a 14614 color
// changed. Only update a value here if 14614 is *meant* to change.
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsphone_competitions/flavors/app14614/app14614.dart';
import 'package:newsphone_competitions/flavors/all_flavors.dart';

void main() {
  final c = app14614.colors;

  const expected = <String, int>{
    'primary': 0xFF0072BC,
    'primary10': 0xFF3393D1,
    'primary20': 0xFF07BCEF,
    'primary30': 0xFF99CDED,
    'primary40': 0xFFCCE5F6,
    'primary50': 0xFFE6F2FA,
    'primary60': 0xFFF2F8FD,
    'primary70': 0xFFF8FBFE,
    'primary80': 0xFFFBFCFE,
    'primary90': 0xFFFEFEFF,
    'primaryDark': 0xFF054279,
    'selectedTint': 0xFFE0F0FF,
    'gradientStart': 0xFFE082FF,
    'gradientEnd': 0xFF0765CB,
    'gradientAccent': 0xFF08C7F4,
    'appBarLogoBackground': 0xFF0072BC,
    'dealGradientStart': 0xFF0072BC,
    'dealGradientEnd': 0xFFED1953,
    'dealGlow': 0xFF5A44E0,
    'successTintEdge': 0xFFECFEFF,
    'successTintMid': 0xFFEFF6FF,
    'switchActive': 0xFF2196F3,
    'resendAction': 0xFF3B5998,
    'link': 0xFF2AB2FF,
    'scaffold': 0xFFFFFFFF,
    'scaffoldMuted': 0xFFF2F4F7,
    'surface': 0xFFFFFFFF,
    'surfaceMuted': 0xFFF2F4F7,
    'surfaceSubtle': 0xFFE7E9EB,
    'buttonDisabled': 0x1F000000,
    'disabledFill': 0xFFE0E0E0,
    'imagePlaceholder': 0xFFE0E0E0,
    'imagePlaceholderStrong': 0xFF555758,
    'divider': 0xFFE0E0E0,
    'dividerMuted': 0xFFA4A7AA,
    'separator': 0xFF555758,
    'navBarBorder': 0x1F000000,
    'outline': 0xFF9E9E9E,
    'outlineMuted': 0xFF989B9F,
    'outlineLight': 0xFFC1C2C6,
    'inputBorder': 0xFF555758,
    'shadow': 0xFF000000,
    'shadowSoft': 0xFF9E9E9E,
    'textPrimary': 0xFF333435,
    'textStrong': 0xFF0C0C0C,
    'textHeading': 0xFF222223,
    'textSecondary': 0xFF555758,
    'textTertiary': 0xFF777A7C,
    'textMuted': 0xFF6F7582,
    'textDisabled': 0xFF9E9E9E,
    'textFaint': 0xFF757575,
    'contrast': 0xFF000000,
    'onPrimary': 0xFFFFFFFF,
    'onImagePlaceholder': 0xFFFFFFFF,
    'iconMuted': 0xFF9E9E9E,
    'navIconInactive': 0xFF616161,
    'indicatorInactive': 0xFFBDBDBD,
    'danger': 0xFFED1953,
    'emphasis': 0xFFED1953,
    'activeState': 0xFF00A113,
    'success': 0xFF1D8E3D,
    'error': 0xFFE72121,
    'errorText': 0xFFF44336,
  };

  final actual = <String, Color>{
    'primary': c.primary,
    'primary10': c.primary10,
    'primary20': c.primary20,
    'primary30': c.primary30,
    'primary40': c.primary40,
    'primary50': c.primary50,
    'primary60': c.primary60,
    'primary70': c.primary70,
    'primary80': c.primary80,
    'primary90': c.primary90,
    'primaryDark': c.primaryDark,
    'selectedTint': c.selectedTint,
    'gradientStart': c.gradientStart,
    'gradientEnd': c.gradientEnd,
    'gradientAccent': c.gradientAccent,
    'appBarLogoBackground': c.appBarLogoBackground,
    'dealGradientStart': c.dealGradientStart,
    'dealGradientEnd': c.dealGradientEnd,
    'dealGlow': c.dealGlow,
    'successTintEdge': c.successTintEdge,
    'successTintMid': c.successTintMid,
    'switchActive': c.switchActive,
    'resendAction': c.resendAction,
    'link': c.link,
    'scaffold': c.scaffold,
    'scaffoldMuted': c.scaffoldMuted,
    'surface': c.surface,
    'surfaceMuted': c.surfaceMuted,
    'surfaceSubtle': c.surfaceSubtle,
    'buttonDisabled': c.buttonDisabled,
    'disabledFill': c.disabledFill,
    'imagePlaceholder': c.imagePlaceholder,
    'imagePlaceholderStrong': c.imagePlaceholderStrong,
    'divider': c.divider,
    'dividerMuted': c.dividerMuted,
    'separator': c.separator,
    'navBarBorder': c.navBarBorder,
    'outline': c.outline,
    'outlineMuted': c.outlineMuted,
    'outlineLight': c.outlineLight,
    'inputBorder': c.inputBorder,
    'shadow': c.shadow,
    'shadowSoft': c.shadowSoft,
    'textPrimary': c.textPrimary,
    'textStrong': c.textStrong,
    'textHeading': c.textHeading,
    'textSecondary': c.textSecondary,
    'textTertiary': c.textTertiary,
    'textMuted': c.textMuted,
    'textDisabled': c.textDisabled,
    'textFaint': c.textFaint,
    'contrast': c.contrast,
    'onPrimary': c.onPrimary,
    'onImagePlaceholder': c.onImagePlaceholder,
    'iconMuted': c.iconMuted,
    'navIconInactive': c.navIconInactive,
    'indicatorInactive': c.indicatorInactive,
    'danger': c.danger,
    'emphasis': c.emphasis,
    'activeState': c.activeState,
    'success': c.success,
    'error': c.error,
    'errorText': c.errorText,
  };

  test('14614 has a value for every color role', () {
    expect(actual.keys.toSet(), expected.keys.toSet());
  });

  for (final role in expected.keys) {
    test('14614 $role is unchanged', () {
      expect(actual[role]!.toARGB32(), expected[role]);
    });
  }

  test('14614 identity is unchanged', () {
    expect(app14614.appName, '14614');
    expect(app14614.phoneNumber, '14614');
    expect(app14614.notificationsTopic, '14614Notifications');
    expect(app14614.stationName, 'ΑΝΤ1');
    expect(app14614.firebaseEnabled, isTrue);
  });

  test('every app is registered under its flavor name', () {
    for (final entry in allFlavors.entries) {
      expect(entry.value.flavorName, entry.key);
    }
  });
}
