import 'package:flutter_test/flutter_test.dart';
import 'package:newsphone_competitions/data/models/brand.dart';
import 'package:newsphone_competitions/data/services/brand_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tests run without a flavor, so FlavorConfig falls back to 14614.
const _fromServer = {
  'id': '14614',
  'name': '14614',
  'station_name': 'ANT1',
  'call_number': '14614',
  'sms_number': '54614',
  'general_topic': '14614Notifications',
  'app_config': {},
};

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    BrandService.resetForTest();
  });

  group('Brand.fromJson', () {
    test('reads the /brand response', () {
      final brand = Brand.fromJson(_fromServer);
      expect(brand.id, '14614');
      expect(brand.callNumber, '14614');
      expect(brand.smsNumber, '54614');
      expect(brand.generalTopic, '14614Notifications');
    });

    test('rejects a response with a missing or empty number', () {
      expect(
        () => Brand.fromJson({..._fromServer, 'sms_number': null}),
        throwsFormatException,
      );
      expect(
        () => Brand.fromJson({..._fromServer, 'call_number': ' '}),
        throwsFormatException,
      );
    });
  });

  test('before any answer the built-in flavor values are used', () {
    final brand = BrandService.current;
    expect(brand.callNumber, '14614');
    expect(brand.smsNumber, '14614');
    expect(brand.generalTopic, '14614Notifications');
  });

  test('a good answer is used and returns the previous values', () async {
    final previous = await BrandService.refresh(
      () async => Brand.fromJson(_fromServer),
    );
    expect(previous?.smsNumber, '14614');
    expect(BrandService.current.smsNumber, '54614');
  });

  test('the same answer again reports no change', () async {
    await BrandService.refresh(() async => Brand.fromJson(_fromServer));
    final previous = await BrandService.refresh(
      () async => Brand.fromJson(_fromServer),
    );
    expect(previous, isNull);
  });

  test('a failed request keeps the current values', () async {
    final previous = await BrandService.refresh(
      () async => throw Exception('offline'),
    );
    expect(previous, isNull);
    expect(BrandService.current.callNumber, '14614');
  });

  test('an answer for another app is ignored', () async {
    final previous = await BrandService.refresh(
      () async => Brand.fromJson({
        ..._fromServer,
        'id': '14800',
        'call_number': '14800',
      }),
    );
    expect(previous, isNull);
    expect(BrandService.current.callNumber, '14614');
  });

  test('the last good answer is used on the next start', () async {
    await BrandService.refresh(() async => Brand.fromJson(_fromServer));
    BrandService.resetForTest(); // app restart
    expect(BrandService.current.smsNumber, '14614');
    await BrandService.loadCached();
    expect(BrandService.current.smsNumber, '54614');
  });
}
