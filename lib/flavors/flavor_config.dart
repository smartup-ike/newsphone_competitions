import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/services.dart' show appFlavor;
import 'package:flutter/material.dart' show Color, ThemeData, Widget;

import 'all_flavors.dart';
import 'app_colors.dart';

/// Everything that makes one app (one number) different from another.
/// The UI and the backend are shared; only these values change.
///
/// To add a new number, see FLAVORS.md → "Add a new number".
class FlavorConfig {
  const FlavorConfig({
    required this.flavorName,
    required this.appId,
    required this.phoneNumber,
    required this.appName,
    required this.stationName,
    required this.stationNameLatin,
    required this.notificationsTopic,
    required this.appLogoAsset,
    required this.stationLogoAsset,
    required this.colors,
    required this.materialTheme,
    required this.poweredByLogoAsset,
    this.stationLogoColor,
    required this.englishTerms,
    required this.greekTerms,
    this.firebaseOptions,
    this.androidNotificationIcon = '@mipmap/launcher_icon',
  });

  /// Same as the `--flavor` name, the Android productFlavor and the iOS scheme.
  final String flavorName;

  /// Identity of the app towards the backend (the number).
  final String appId;

  /// Premium-rate number users call / send SMS to.
  final String phoneNumber;

  /// User-facing app name ("14614").
  final String appName;

  /// TV channel in Greek ("ΑΝΤ1") and Latin ("ANT1") script.
  final String stationName;
  final String stationNameLatin;

  /// FCM topic every install subscribes to.
  final String notificationsTopic;

  /// Number logo (app bar left box, About page). Can be .png or .svg.
  final String appLogoAsset;

  /// TV channel logo (app bar centre box). Can be .png or .svg.
  final String stationLogoAsset;

  /// The app's color template.
  final AppColors colors;

  /// Material theme (defaults for dialogs, sheets, plain text, inputs…).
  /// Light apps keep Flutter's defaults; dark apps build a dark theme.
  final ThemeData Function() materialTheme;

  /// "Powered by Smartup" logo in Settings (light or dark version).
  final String poweredByLogoAsset;

  /// Paints a one-color .svg channel logo in this color (e.g. white on a
  /// dark app bar). `null` = draw the logo with its own colors.
  final Color? stationLogoColor;

  /// Terms of use, per app.
  final List<Widget> Function() englishTerms;
  final List<Widget> Function() greekTerms;

  /// `null` = Firebase not set up for this app yet: the app runs without
  /// login, coupons, push notifications and analytics.
  final FirebaseOptions Function()? firebaseOptions;

  /// Small icon of Android notifications shown by the app itself (in the
  /// foreground). Android draws it as a one-color silhouette, so it should be
  /// white on transparent. Notifications shown by FCM while the app is in the
  /// background use `default_notification_icon` in the flavor's
  /// AndroidManifest.xml; keep the two the same.
  final String androidNotificationIcon;

  bool get firebaseEnabled => firebaseOptions != null;

  static FlavorConfig? _instance;

  /// The app this build was made for (`--flavor`). Builds without a flavor
  /// (e.g. tests) fall back to 14614.
  static FlavorConfig get instance =>
      _instance ??= allFlavors[appFlavor] ?? allFlavors['app14614']!;
}
