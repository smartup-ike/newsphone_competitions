import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsphone_competitions/data/models/contest_categories.dart';
import '../models/contests.dart';
import '../models/deals.dart';
import '../models/topics.dart';

class ApiService {
  final String _baseUrl =
      'https://newsphone-api-560508338889.europe-central2.run.app';

  /// Fetch contests from API
  Future<List<Contest>> fetchContests() async {
    final url = '$_baseUrl/contests';

    try {
      final response = await http.get(Uri.parse(url));
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
    final url = '$_baseUrl/deals';

    try {
      final response = await http.get(Uri.parse(url));
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

  ///Fetch topics of notifications
  Future<List<Topic>> fetchTopic() async {
    final url = '$_baseUrl/topics';
    try {
      final response = await http.get(Uri.parse(url));
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
      final response = await http.get(Uri.parse(url));
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

  /// Register user with Firebase ID token
  Future<Map<String, dynamic>> registerUser(String idToken) async {
    final url = '$_baseUrl/auth/register';
    final body = json.encode({'idToken': idToken});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
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
}
