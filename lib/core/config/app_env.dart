import 'package:flutter/foundation.dart' show kReleaseMode;

/// Which backend the app talks to.
///
/// Production is the default and needs no flags. To use another backend
/// (e.g. staging) pass a local, git-ignored env file:
///
/// ```bash
/// flutter run --flavor app14800 --dart-define-from-file=env/staging.json
/// ```
///
/// See `env/staging.example.json` and FLAVORS.md → "Environments".
///
/// **Release builds always use production.** An env file passed to a
/// release build is ignored, so a staging URL can never reach the stores.
class AppEnv {
  AppEnv._();

  static const String _productionApiUrl =
      'https://newsphone-api-560508338889.europe-central2.run.app';

  static const String _name = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'production',
  );

  static const String _apiUrlOverride = String.fromEnvironment('API_BASE_URL');

  /// `production`, `staging`, … (always `production` in release builds).
  static String get name =>
      kReleaseMode || _apiUrlOverride.isEmpty ? 'production' : _name;

  static bool get isProduction => name == 'production';

  /// Base URL of the Newsphone API, without a trailing slash.
  static String get apiBaseUrl =>
      isProduction
          ? _productionApiUrl
          : _apiUrlOverride.replaceFirst(RegExp(r'/+$'), '');
}
