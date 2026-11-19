import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsphone_competitions/data/models/contest_categories.dart';
import 'package:newsphone_competitions/data/models/user_transaction.dart';
import '../models/brand.dart';
import '../models/contests.dart';
import '../models/deals.dart';
import '../models/topics.dart';
import '../demo/demo_data.dart';
import '../../core/config/app_env.dart';
import '../../flavors/flavor_config.dart';

class ApiService {
  /// Headers sent with every request.
  ///
  /// `X-Brand` tells the backend which app (number) is calling, so it returns
  /// that app's contests, deals, users and coupons.
  Map<String, String> _headers({String? idToken, bool json = false}) => {
    'X-Brand': FlavorConfig.instance.appId,
    if (json) 'Content-Type': 'application/json',
    if (idToken != null) 'Authorization': 'Bearer $idToken',
  };

  /// Production unless a debug build was started with an env file
  /// (see [AppEnv]).
  final String _baseUrl = AppEnv.apiBaseUrl;

  /// Fetch contests from API
  Future<List<Contest>> fetchContests() async {
    if (DemoData.enabled) return DemoData.contests();
    final url = '$_baseUrl/contests';

    try {
      final response = await http.get(Uri.parse(url), headers: _headers());
      //log("/deals contests: ${response.body}");

      if (response.statusCode == 200) {
        // Decode the JSON response and map it to a list of Contest objects
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((contestJson) => Contest.fromJson(contestJson))
            .toList();
      } else {
        // Handle API errors (non-200 responses)
        throw Exception('Failed to load contests: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw Exception('Failed to load contests: $e');
    }
  }

  /// Fetch deals from API
  Future<List<Deal>> apiFetchDeals() async {
    if (DemoData.enabled) return DemoData.deals();
    final url = '$_baseUrl/deals';

    try {
      final response = await http.get(Uri.parse(url), headers: _headers());
      //log("/deals response: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((dealJson) => Deal.fromJson(dealJson)).toList();
      } else {
        // Handle API errors (non-200 responses)
        throw Exception('Failed to load deals: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw Exception('Failed to load deals: $e');
    }
  }

  /// Fetch one contest by id, regardless of its time window or active flag
  Future<Contest> fetchContestById(int id) async {
    if (DemoData.enabled) {
      return DemoData.contests().firstWhere(
        (c) => c.id == 'demo-$id',
        orElse: () => DemoData.contests().first,
      );
    }
    final url = '$_baseUrl/contests/$id';

    try {
      final response = await http.get(Uri.parse(url), headers: _headers());

      if (response.statusCode == 200) {
        return Contest.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load contest $id: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load contest $id: $e');
    }
  }

  /// Fetch one deal by id, regardless of its time window or active flag
  Future<Deal> fetchDealById(int id) async {
    if (DemoData.enabled) {
      return DemoData.deals().firstWhere(
        (d) => d.id == 'demo-deal-$id',
        orElse: () => DemoData.deals().first,
      );
    }
    final url = '$_baseUrl/deals/$id';

    try {
      final response = await http.get(Uri.parse(url), headers: _headers());

      if (response.statusCode == 200) {
        return Deal.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load deal $id: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load deal $id: $e');
    }
  }

  ///Fetch topics of notifications
  Future<List<Topic>> fetchTopic() async {
    final url = '$_baseUrl/topics';
    try {
      final response = await http.get(Uri.parse(url), headers: _headers());
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((topicJson) => Topic.fromJson(topicJson)).toList();
      } else {
        // Handle API errors (non-200 responses)
        throw Exception('Failed to load deals: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw Exception('Failed to load deals: $e');
    }
  }

  ///Fetch categories of contests
  Future<List<ContestCategories>> fetchCategories() async {
    final url = '$_baseUrl/contest-categories';
    try {
      final response = await http.get(Uri.parse(url), headers: _headers());
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((categoriesJson) => ContestCategories.fromJson(categoriesJson))
            .toList();
      } else {
        // Handle API errors (non-200 responses)
        throw Exception('Failed to load deals: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw Exception('Failed to load deals: $e');
    }
  }

  /// Station details for this app: call/SMS numbers and notification topic.
  /// Throws on any error; [BrandService] then keeps the values it has.
  Future<Brand> fetchBrand() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/brand'), headers: _headers())
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('GET /brand: ${response.statusCode}');
    }
    return Brand.fromJson(
      json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
    );
  }

  /// Register user with Firebase ID token
  Future<Map<String, dynamic>> registerUser(String idToken) async {
    print('idToken : ${idToken}');
    final url = '$_baseUrl/auth/register';
    final body = json.encode({'idToken': idToken});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(json: true),
        body: body,
      );

      if (response.statusCode == 200) {
        // Successful registration, parse the JSON
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 422) {
        // Validation error
        final error = json.decode(response.body);
        throw Exception('Validation Error: $error');
      } else {
        throw Exception('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  ///Fetch categories of contests
  Future<Map<String, dynamic>> fetchMe(String idToken) async {
    final url = '$_baseUrl/users/me';

    final response = await http.get(
      Uri.parse(url),
      headers: _headers(idToken: idToken, json: true),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch user: ${response.statusCode}');
    }
  }

  /// Fetch coupon history for the current authenticated user
  Future<List<UserTransaction>> fetchCouponHistory(String idToken) async {
    final url = '$_baseUrl/coupons/history';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(idToken: idToken, json: true),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => UserTransaction.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch coupon history: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch coupon history: $e');
    }
  }

  /// Spend coupons on a contest or deal
  Future<Map<String, dynamic>> spendCoupons({
    required String idToken,
    required int amount,
    int? contestId,
    int? dealId,
  }) async {
    final url = '$_baseUrl/coupons/spend';

    // Build the request body
    final body = json.encode({'amount': amount, 'contest_id': contestId ?? 0});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(idToken: idToken, json: true),
        body: body,
      );

      if (response.statusCode == 200) {
        // Returns a string message from the API
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 422) {
        final error = json.decode(response.body);
        throw Exception('Validation Error: $error');
      } else {
        throw Exception('Failed to spend coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to spend coupons: $e');
    }
  }

  /// Register a test device
  Future<Map<String, dynamic>> registerTestDevice({
    required String name,
    required String fcmToken,
  }) async {
    final url = '$_baseUrl/test-devices';
    final body = json.encode({'name': name, 'fcm_token': fcmToken});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(json: true),
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 422) {
        final error = json.decode(response.body);
        throw Exception('Validation Error: $error');
      } else {
        throw Exception(
          'Failed to register test device: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to register test device: $e');
    }
  }
}
