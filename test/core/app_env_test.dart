import 'package:flutter_test/flutter_test.dart';
import 'package:newsphone_competitions/core/config/app_env.dart';

void main() {
  // Tests run without --dart-define-from-file, exactly like a normal build.
  test('without an env file the app uses the production API', () {
    expect(AppEnv.isProduction, isTrue);
    expect(AppEnv.name, 'production');
    expect(
      AppEnv.apiBaseUrl,
      'https://newsphone-api-560508338889.europe-central2.run.app',
    );
  });
}
