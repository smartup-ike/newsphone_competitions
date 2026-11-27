import 'package:flutter/material.dart';
import 'package:newsphone_competitions/flavors/app_colors.dart';
import 'package:newsphone_competitions/flavors/flavor_config.dart';

class NewsphoneTheme {
  //! Color roles: they come from the app (flavor) being built.
  //! Use these for anything that should follow the app's color template.
  static AppColors get _c => FlavorConfig.instance.colors;

  // Brand
  static Color get primary => _c.primary;
  static Color get primary10 => _c.primary10;
  static Color get primary20 => _c.primary20;
  static Color get primary30 => _c.primary30;
  static Color get primary40 => _c.primary40;
  static Color get primary50 => _c.primary50;
  static Color get primary60 => _c.primary60;
  static Color get primary70 => _c.primary70;
  static Color get primary80 => _c.primary80;
  static Color get primary90 => _c.primary90;
  static Color get primaryDark => _c.primaryDark;
  static Color get selectedTint => _c.selectedTint;
  static Color get gradientStart => _c.gradientStart;
  static Color get gradientEnd => _c.gradientEnd;
  static Color get gradientAccent => _c.gradientAccent;
  static Color get appBarLogoBackground => _c.appBarLogoBackground;
  static Color get dealGradientStart => _c.dealGradientStart;
  static Color get dealGradientEnd => _c.dealGradientEnd;
  static Color get dealGlow => _c.dealGlow;
  static Color get successTintEdge => _c.successTintEdge;
  static Color get successTintMid => _c.successTintMid;
  static Color get switchActive => _c.switchActive;
  static Color get resendAction => _c.resendAction;
  static Color get link => _c.link;
  // Backgrounds
  static Color get scaffold => _c.scaffold;
  static Color get scaffoldMuted => _c.scaffoldMuted;
  static Color get surface => _c.surface;
  static Color get surfaceMuted => _c.surfaceMuted;
  static Color get surfaceSubtle => _c.surfaceSubtle;
  static Color get buttonDisabled => _c.buttonDisabled;
  static Color get disabledFill => _c.disabledFill;
  static Color get imagePlaceholder => _c.imagePlaceholder;
  static Color get imagePlaceholderStrong => _c.imagePlaceholderStrong;
  // Lines
  static Color get divider => _c.divider;
  static Color get dividerMuted => _c.dividerMuted;
  static Color get separator => _c.separator;
  static Color get navBarBorder => _c.navBarBorder;
  static Color get outline => _c.outline;
  static Color get outlineMuted => _c.outlineMuted;
  static Color get outlineLight => _c.outlineLight;
  static Color get inputBorder => _c.inputBorder;
  static Color get shadow => _c.shadow;
  static Color get shadowSoft => _c.shadowSoft;
  // Text
  static Color get textPrimary => _c.textPrimary;
  static Color get textStrong => _c.textStrong;
  static Color get textHeading => _c.textHeading;
  static Color get textSecondary => _c.textSecondary;
  static Color get textTertiary => _c.textTertiary;
  static Color get textMuted => _c.textMuted;
  static Color get textDisabled => _c.textDisabled;
  static Color get textFaint => _c.textFaint;
  static Color get contrast => _c.contrast;
  static Color get onPrimary => _c.onPrimary;
  static Color get onImagePlaceholder => _c.onImagePlaceholder;
  // Icons
  static Color get iconMuted => _c.iconMuted;
  static Color get navIconInactive => _c.navIconInactive;
  static Color get indicatorInactive => _c.indicatorInactive;
  // States
  static Color get danger => _c.danger;
  static Color get emphasis => _c.emphasis;
  static Color get activeState => _c.activeState;
  static Color get success => _c.success;
  static Color get error => _c.error;
  static Color get errorText => _c.errorText;

  //! Fixed colors below are the same in every app. Use them only for
  //! things that never change with the app theme (video overlays, toasts).

  //! Neutral
  static const Color neutralBlack = Color(0xFF0C0C0C);
  static const Color neutral10 = Color(0xFF222223);
  static const Color neutral20 = Color(0xFF333435);

  static const Color neutral30 = Color(0xFF555758);
  static const Color neutral35 = Color(0xFF6F7582);
  static const Color neutral40 = Color(0xFF777A7C);

  static const Color neutral50 = Color(0xFF989B9F);
  static const Color neutral60 = Color(0xFFA4A7AA);
  static const Color neutral70 = Color(0xFFC1C2C6);
  static const Color neutral80 = Color(0xFFDADCDE);
  static const Color neutral90 = Color(0xFFE7E9EB);
  static const Color neutral95 = Color(0xFFF2F4F7);
  static const Color neutral99 = Color(0xFFF5F5F7);
  static const Color neutralWhite = Color(0xFFFFFFFF);

  //! info
  static const Color info20 = Color(0xFF0070AE);
  static const Color info30 = Color(0xFF008FDF);
  static const Color info50 = Color(0xFF2AB2FF);
  static const Color info70 = Color(0xFF7DD0FF);
  static const Color info90 = Color(0xFFC0E8FF);
  static const Color info95 = Color(0xFFE6F6FF);

  //! states
  static const Color active = Color(0xFF00A113); // Color for active state
  static const Color deactivate = Color(
    0xFFED1953,
  ); // Color for deactivate state

  //! warning
  static const Color warning20 = Color(0xFFC88200);
  static const Color warning30 = Color(0xFFF49E00);
  static const Color warning50 = Color(0xFFF7B63F);
  static const Color warning70 = Color(0xFFFAD289);
  static const Color warning90 = Color(0xFFFCE5BB);
  static const Color warning95 = Color(0xFFFDF4E4);

  //! error
  static const Color error20 = Color(0xFFBE1010);
  static const Color error30 = Color(0xFFE72121);
  static const Color error50 = Color(0xFFFF7272);
  static const Color error70 = Color(0xFFFFBBBB);
  static const Color error90 = Color(0xFFFFE0E0);
  static const Color error95 = Color(0xFFFFF0F0);

  //! shadows
  static const Color blueShadowColor = Color(0x330B3751);
  static const Color shadowColor = Color(0x1F002940);
}
