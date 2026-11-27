import 'package:flutter/painting.dart' show Color;

/// The color template of one app: one color per *role* (what the color is
/// used for), not per shade. Every app fills in every role, so an app can be
/// light or dark without touching any screen.
///
/// Screens read these through `NewsphoneTheme.<role>`.
class AppColors {
  const AppColors({
    required this.primary,
    required this.primary10,
    required this.primary20,
    required this.primary30,
    required this.primary40,
    required this.primary50,
    required this.primary60,
    required this.primary70,
    required this.primary80,
    required this.primary90,
    required this.primaryDark,
    required this.selectedTint,
    required this.gradientStart,
    required this.gradientEnd,
    required this.gradientAccent,
    required this.appBarLogoBackground,
    required this.dealGradientStart,
    required this.dealGradientEnd,
    required this.dealGlow,
    required this.successTintEdge,
    required this.successTintMid,
    required this.switchActive,
    required this.resendAction,
    required this.link,
    required this.scaffold,
    required this.scaffoldMuted,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceSubtle,
    required this.buttonDisabled,
    required this.disabledFill,
    required this.imagePlaceholder,
    required this.imagePlaceholderStrong,
    required this.divider,
    required this.dividerMuted,
    required this.separator,
    required this.navBarBorder,
    required this.outline,
    required this.outlineMuted,
    required this.outlineLight,
    required this.inputBorder,
    required this.shadow,
    required this.shadowSoft,
    required this.textPrimary,
    required this.textStrong,
    required this.textHeading,
    required this.textSecondary,
    required this.textTertiary,
    required this.textMuted,
    required this.textDisabled,
    required this.textFaint,
    required this.contrast,
    required this.onPrimary,
    required this.onImagePlaceholder,
    required this.iconMuted,
    required this.navIconInactive,
    required this.indicatorInactive,
    required this.danger,
    required this.emphasis,
    required this.activeState,
    required this.success,
    required this.error,
    required this.errorText,
  });

  // Brand
  /// Main brand color.
  final Color primary;
  /// Brand scale.
  final Color primary10;
  /// Secondary brand color (buttons, chips).
  final Color primary20;
  /// Brand scale.
  final Color primary30;
  /// Selected chip background.
  final Color primary40;
  /// Light brand tint.
  final Color primary50;
  /// Brand scale.
  final Color primary60;
  /// Brand scale.
  final Color primary70;
  /// Brand scale.
  final Color primary80;
  /// Brand scale.
  final Color primary90;
  /// Dark brand color for text/borders.
  final Color primaryDark;
  /// Background of a selected option.
  final Color selectedTint;
  /// Main gradient start.
  final Color gradientStart;
  /// Main gradient end.
  final Color gradientEnd;
  /// Step-number gradient start.
  final Color gradientAccent;
  /// Box behind the number logo in the app bar.
  final Color appBarLogoBackground;
  /// Deal button gradient start.
  final Color dealGradientStart;
  /// Deal button gradient end.
  final Color dealGradientEnd;
  /// Glow around the deal code button.
  final Color dealGlow;
  /// Login success card gradient (edges).
  final Color successTintEdge;
  /// Login success card gradient (middle).
  final Color successTintMid;
  /// Active switch.
  final Color switchActive;
  /// Resend-code action.
  final Color resendAction;
  /// Links in text.
  final Color link;
  // Backgrounds
  /// Page background (plain pages).
  final Color scaffold;
  /// Page background (grey pages: settings, coupons…).
  final Color scaffoldMuted;
  /// Cards, app bars, sheets, dialogs, menus.
  final Color surface;
  /// Secondary containers (info boxes, deal cards, sheets).
  final Color surfaceMuted;
  /// App bar boxes, unselected nav items.
  final Color surfaceSubtle;
  /// Disabled gradient button.
  final Color buttonDisabled;
  /// Background of a disabled button.
  final Color disabledFill;
  /// Image placeholder (light).
  final Color imagePlaceholder;
  /// Image placeholder (dark).
  final Color imagePlaceholderStrong;
  // Lines
  /// Divider lines, sheet handles, light borders.
  final Color divider;
  /// Divider in the instructions.
  final Color dividerMuted;
  /// List separators (notifications).
  final Color separator;
  /// Top border of the bottom nav bar.
  final Color navBarBorder;
  /// Option borders.
  final Color outline;
  /// Chip / sheet borders.
  final Color outlineMuted;
  /// Outlined button border.
  final Color outlineLight;
  /// Search field border.
  final Color inputBorder;
  /// Card shadow (used with opacity).
  final Color shadow;
  /// Soft input shadow (used with opacity).
  final Color shadowSoft;
  // Text
  /// Default text.
  final Color textPrimary;
  /// Titles and strong icons.
  final Color textStrong;
  /// Dialog headings.
  final Color textHeading;
  /// Secondary text and icons.
  final Color textSecondary;
  /// Subtitles.
  final Color textTertiary;
  /// Descriptions.
  final Color textMuted;
  /// Disabled / footnote text.
  final Color textDisabled;
  /// Timer text.
  final Color textFaint;
  /// Max-contrast color: input text, cursor, menu icon.
  final Color contrast;
  /// Text/icons on brand colors and gradients.
  final Color onPrimary;
  /// Icon on an image placeholder.
  final Color onImagePlaceholder;
  // Icons
  /// Muted icons.
  final Color iconMuted;
  /// Unselected bottom nav icon.
  final Color navIconInactive;
  /// Unselected page dot.
  final Color indicatorInactive;
  // States
  /// Ended contest, delete, unread dot.
  final Color danger;
  /// Highlighted text in instructions and prices.
  final Color emphasis;
  /// Running contest dot.
  final Color activeState;
  /// Success message.
  final Color success;
  /// Error message.
  final Color error;
  /// Inline error text.
  final Color errorText;
}
