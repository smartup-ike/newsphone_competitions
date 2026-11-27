// iOS phone login crashes ("send code") when these settings disagree:
// FirebaseAuth looks for a URL scheme built from the iOS client id, and if the
// app does not register it, it stops the app with a fatal error. This happened
// in 14614 1.1.9 (no iosClientId). These tests fail before a build that would
// crash ever reaches the stores.
//
// For every flavor, three places must agree:
//   1. lib/flavors/<flavor>/firebase_options.dart  (iosClientId, bundle, app id)
//   2. ios/config/<flavor>/GoogleService-Info.plist (CLIENT_ID, REVERSED_CLIENT_ID)
//   3. ios/Runner.xcodeproj  (GOOGLE_REVERSED_CLIENT_ID per build configuration,
//      used as the URL scheme in ios/Runner/Info.plist)
import 'dart:io';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:newsphone_competitions/flavors/app14614/firebase_options.dart';
import 'package:newsphone_competitions/flavors/app14800/firebase_options.dart';

/// Value of `<key>name</key><string>value</string>` in a plist.
String? plistValue(String plist, String key) => RegExp(
  '<key>${RegExp.escape(key)}</key>\\s*<string>([^<]*)</string>',
).firstMatch(plist)?.group(1);

/// Every XCBuildConfiguration of the app target with this bundle id, as
/// configuration name -> GOOGLE_REVERSED_CLIENT_ID (null when missing).
Map<String, String?> reversedClientIdsFor(String pbxproj, String bundleId) {
  final configs = RegExp(
    r'/\* ([^*]+) \*/ = \{\s*isa = XCBuildConfiguration;(.*?)\n\t\t\};',
    dotAll: true,
  );
  final result = <String, String?>{};
  for (final m in configs.allMatches(pbxproj)) {
    final body = m.group(2)!;
    final bundle = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER = "?([^";]+)"?;',
    ).firstMatch(body)?.group(1);
    if (bundle != bundleId) continue;
    result['${m.group(1)} (${result.length})'] = RegExp(
      r'GOOGLE_REVERSED_CLIENT_ID = "?([^";]+)"?;',
    ).firstMatch(body)?.group(1);
  }
  return result;
}

void main() {
  final flavors = <String, FirebaseOptions>{
    'app14614': App14614FirebaseOptions.ios,
    'app14800': App14800FirebaseOptions.ios,
  };

  final infoPlist = File('ios/Runner/Info.plist').readAsStringSync();
  final pbxproj = File(
    'ios/Runner.xcodeproj/project.pbxproj',
  ).readAsStringSync();

  test('Info.plist registers the Google reversed client id as a URL scheme',
      () {
    expect(infoPlist, contains('<string>\$(GOOGLE_REVERSED_CLIENT_ID)</string>'));
  });

  flavors.forEach((flavor, options) {
    group(flavor, () {
      final plist = File(
        'ios/config/$flavor/GoogleService-Info.plist',
      ).readAsStringSync();
      final clientId = plistValue(plist, 'CLIENT_ID');
      final reversed = plistValue(plist, 'REVERSED_CLIENT_ID');
      final bundleId = plistValue(plist, 'BUNDLE_ID');

      test('GoogleService-Info.plist has the iOS OAuth client', () {
        expect(clientId, isNotNull, reason: 'Download a fresh plist from Firebase');
        expect(reversed, isNotNull);
        expect(
          reversed,
          'com.googleusercontent.apps.${clientId!.replaceFirst('.apps.googleusercontent.com', '')}',
        );
      });

      test('firebase_options.dart matches GoogleService-Info.plist', () {
        expect(options.iosClientId, clientId,
            reason: 'Missing/wrong iosClientId crashes phone login on iOS');
        expect(options.iosBundleId, bundleId);
        expect(options.appId, plistValue(plist, 'GOOGLE_APP_ID'));
        expect(options.projectId, plistValue(plist, 'PROJECT_ID'));
      });

      test('every Xcode configuration of the app sets the URL scheme', () {
        final configs = reversedClientIdsFor(pbxproj, bundleId!);
        expect(configs, isNotEmpty,
            reason: 'No build configuration uses bundle id $bundleId');
        configs.forEach((name, value) {
          expect(value, reversed,
              reason: '$name: GOOGLE_REVERSED_CLIENT_ID must be $reversed');
        });
      });
    });
  });
}
