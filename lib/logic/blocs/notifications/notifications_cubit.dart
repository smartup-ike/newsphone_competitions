import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsphone_competitions/data/models/contests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/deals.dart';
import '../../../data/models/notification.dart';
import '../../../data/models/topics.dart';
import '../../../data/services/analytics_service.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/notifications_services.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);

  // Use a late final box
  late final Box<AppNotification> _box;bool get isBoxReady => _box.isOpen;
  late StreamSubscription<BoxEvent> _subscription;

  // Keep track of selected topic IDs
  Set<String> _selectedTopics = {};

  Set<String> get selectedTopics => _selectedTopics;

  // List of topics fetched from API
  List<Topic> topics = [];

  final ApiService _apiService;

  bool get isSubscribedToAnyTopic => _selectedTopics.isNotEmpty;

  NotificationCubit(this._apiService) : super([]);

  void init() async {
    _box = await Hive.openBox<AppNotification>('notifications');
    // Listen for changes to the box
    _subscription = _box.watch().listen((event) {
      loadNotifications();
    });
    // Load initial notifications
    loadNotifications();
    await _loadSelectedTopics();
    await fetchTopicsFromApi();

    // Load saved topics from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    _selectedTopics = (prefs.getStringList('selectedTopics') ?? []).toSet();

    await _subscribeToTopics(_selectedTopics);
  }

  Future<void> fetchTopicsFromApi() async {
    try {
      topics = await _apiService.fetchTopic();
      emit(List.from(state)); // trigger rebuild
    } catch (e) {
      // You can handle errors here
      topics = [];
    }
  }

  Future<void> _loadSelectedTopics() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedTopics = (prefs.getStringList('selectedTopics') ?? []).toSet();

    // Ensure default topic
    if (_selectedTopics.isEmpty && topics.isNotEmpty) {
      _selectedTopics.add(topics.first.id.toString());
    }

    // Subscribe to selected topics
    await _subscribeToTopics(_selectedTopics);
  }

  Future<void> toggleTopic(String topicId) async {
    final prefs = await SharedPreferences.getInstance();
    final isSubscribing = !_selectedTopics.contains(topicId);

    if (_selectedTopics.contains(topicId)) {
      _selectedTopics.remove(topicId);
      await NotificationService.unsubscribeFromTopic(topicId);
    } else {
      _selectedTopics.add(topicId);
      await NotificationService.subscribeToTopic(topicId);
    }

    await prefs.setStringList('selectedTopics', _selectedTopics.toList());
    emit(List.from(state));
  }

  void loadNotifications() {
    final reversed = _box.values.toList().reversed.toList();
    emit(reversed);
  }

  void addNotification(AppNotification notification) {
    _box.add(notification);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void markAllAsRead() {
    final newState =
        state.map((notification) {
          if (!notification.isRead) {
            notification.isRead = true;
            notification.save(); // update Hive
          }
          return notification;
        }).toList();
    emit(newState);
  }

  void markNotificationAsRead(AppNotification notificationToMark) {
    final newState =
        state.map((notification) {
          if (notification.key == notificationToMark.key &&
              !notification.isRead) {
            notification.isRead = true;
            notification.save();
          }
          return notification;
        }).toList();
    emit(newState);
  }

  Future<void> deleteAllNotifications() async {
    await _box.clear(); // clears all data in the box
    emit([]); // update state to empty list
  }

  Future<void> deleteNotification(AppNotification notification) async {
    await notification.delete(); // removes from Hive
    loadNotifications(); // update state
  }

  Future<void> _subscribeToTopics(Set<String> topics) async {
    for (var topic in topics) {
      await NotificationService.subscribeToTopic(topic);
    }
  }

  Future<void> unsubscribeFromAllTopics() async {
    final prefs = await SharedPreferences.getInstance();

    // Copy current topics to avoid modifying set while iterating
    final topicsToUnsubscribe = _selectedTopics.toList();

    // Unsubscribe from all topics
    for (var topic in topicsToUnsubscribe) {
      await NotificationService.unsubscribeFromTopic(topic);
    }

    // Clear local state
    _selectedTopics.clear();

    // Save empty list to SharedPreferences
    await prefs.setStringList('selectedTopics', []);

    AnalyticsService.logTopicSubscriptionAll(false);

    emit(List.from(state));
  }

  /// Subscribe to all available topics, fetching them first if necessary
  Future<void> subscribeToAllTopics() async {
    final prefs = await SharedPreferences.getInstance();

    // Fetch topics from API if the list is empty
    if (topics.isEmpty) {
      await fetchTopicsFromApi();
    }

    // If still empty (API failed), do nothing
    if (topics.isEmpty) return;

    // Map all topic IDs to a set
    _selectedTopics = topics.map((t) => t.name.toString()).toSet();

    // Save all topic IDs to SharedPreferences
    await prefs.setStringList('selectedTopics', _selectedTopics.toList());

    // Subscribe to all topics via NotificationService
    await _subscribeToTopics(_selectedTopics);

    AnalyticsService.logTopicSubscriptionAll(true);

    // Trigger rebuild
    emit(List.from(state));
  }

  void setSubscriptionState(bool isSubscribed) {
    if (isSubscribed) {
      // just mark as subscribed locally (no network yet)
      _selectedTopics = {'temp'};
    } else {
      _selectedTopics.clear();
    }
    emit(List.from(state)); // trigger UI rebuild
  }

  Future<dynamic> openContentFromNotifications(
    int? contestId,
    int? dealId,
    String? type,
  ) async {
    final apiService = ApiService();

    try {
      // 1️⃣ Fetch all contests and deals simultaneously
      final contestsFuture = apiService.fetchContests();
      final dealsFuture = apiService.apiFetchDeals();

      final results = await Future.wait([contestsFuture, dealsFuture]);

      final contests = results[0] as List<Contest>;
      final deals = results[1] as List<Deal>;

      // 2️⃣ Find the contest if contestId is provided
      if (type == 'contest' && contestId != null) {
        final contest = contests.firstWhere(
          (c) => int.tryParse(c.id) == contestId,
          orElse: () => throw Exception('Contest not found'),
        );
        AnalyticsService.logNotificationOpen(
          'Content',
          contest.id,
          contest.name,
        );
        return contest;
      }

      // 3️⃣ Find the deal if dealId is provided
      if (type == 'deal' && contestId != null) {
        final deal = deals.firstWhere(
          (d) => int.tryParse(d.id) == dealId,
          orElse: () => throw Exception('Deal not found'),
        );
        AnalyticsService.logNotificationOpen('Deal', deal.id, deal.name);
        return deal;
      }

      // 4️⃣ If neither ID is provided
      return null;
    } catch (e) {
      developer.log("Error opening content: $e");
      return null;
    }
  }
}
