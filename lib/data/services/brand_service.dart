import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/app_env.dart';
import '../../flavors/flavor_config.dart';
import '../models/brand.dart';

/// The station's call/SMS numbers and notification topic, from the backend.
///
/// On start the app uses the last values it saved (or the flavor's built-in
/// ones the first time), then asks `GET /brand` for fresh values in the
/// background. If the request fails, nothing changes: the app keeps working
/// with the values it has.
class BrandService {
  BrandService._();

  static Brand? _current;

  /// The values to use right now. Never null.
  static Brand get current => _current ??= Brand.fromFlavor(_flavor);

  static FlavorConfig get _flavor => FlavorConfig.instance;

  /// One saved copy per app and backend, so staging values never leak into
  /// a production run.
  static String get _cacheKey => 'brand_${_flavor.appId}_${AppEnv.name}';

  /// Loads the values saved by the last successful [refresh].
  static Future<void> loadCached() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_cacheKey);
      if (saved == null) return;
      final brand = Brand.fromJson(jsonDecode(saved) as Map<String, dynamic>);
      if (brand.id == _flavor.appId) _current = brand;
    } catch (e) {
      developer.log('Brand: ignoring saved values: $e');
    }
  }

  /// Fetches fresh values with [fetch] (normally `ApiService.fetchBrand`).
  ///
  /// Returns the previous values when they changed, so the caller can move
  /// the notification topic; returns `null` when nothing changed or the
  /// request failed.
  static Future<Brand?> refresh(Future<Brand> Function() fetch) async {
    try {
      final fresh = await fetch();
      // Answer for another app (e.g. wrong backend): never use it.
      if (fresh.id != _flavor.appId) {
        developer.log('Brand: got "${fresh.id}", expected "${_flavor.appId}"');
        return null;
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(fresh.toJson()));

      final previous = current;
      if (fresh == previous) return null;
      _current = fresh;
      return previous;
    } catch (e) {
      developer.log('Brand: keeping current values ($e)');
      return null;
    }
  }

  /// For tests only.
  static void resetForTest() => _current = null;
}
