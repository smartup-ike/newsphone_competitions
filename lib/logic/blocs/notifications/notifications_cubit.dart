import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/notification.dart';
import '../../../data/models/topics.dart';
import '../../../data/services/analytics_service.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/notifications_services.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);

  Box<AppNotification>? _box;

  bool get isBoxReady => _box?.isOpen ?? false;
  StreamSubscription<BoxEvent>? _subscription;
  AppLifecycleListener? _lifecycleListener;
  Future<void>? _reloading;

  // Keep track of selected topic IDs
  Set<String> _selectedTopics = {};

  Set<String> get selectedTopics => _selectedTopics;

  // List of topics fetched from API
  List<Topic> topics = [];

  final ApiService _apiService;

  bool get isSubscribedToAnyTopic => _selectedTopics.isNotEmpty;

  NotificationCubit(this._apiService) : super([]);

  void init() async {
    await reloadFromDisk();
    // The background isolate writes to the box on disk; pick those writes up
    // whenever the app comes back to the foreground.
    _lifecycleListener = AppLifecycleListener(onResume: reloadFromDisk);

    final prefs = await SharedPreferences.getInstance();
    // Check if topics have ever been initialized
    bool isFirstRun = prefs.getBool('notifications_initialized') ?? true;

    await fetchTopicsFromApi();

    if (isFirstRun) {
      if (topics.isNotEmpty) {
        await subscribeToAllTopics();
        await prefs.setBool('notifications_initialized', false);
      }
    } else {
      _selectedTopics = (prefs.getStringList('selectedTopics') ?? []).toSet();
      await _subscribeToTopics(_selectedTopics);
    }
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
    final box = _box;
    if (box == null || !box.isOpen) return;
    final sorted = box.values.toList()
      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));
    emit(sorted);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _lifecycleListener?.dispose();
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
    await NotificationService.rememberDeletedIds(state.map((n) => n.id));
    await _box?.clear(); // clears all data in the box
    emit([]); // update state to empty list
  }

  Future<void> deleteNotification(AppNotification notification) async {
    await NotificationService.rememberDeletedIds([notification.id]);
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

  Future<void> toggleAllNotifications(bool value) async {
    // Optimistic update
    final previousTopics = Set<String>.from(_selectedTopics);
    setSubscriptionState(value);

    try {
      if (value) {
        await subscribeToAllTopics();
      } else {
        await unsubscribeFromAllTopics();
      }
    } catch (e) {
      // Revert on failure
      _selectedTopics = previousTopics;
      emit(List.from(state));
      rethrow;
    }
  }

  /// Returns the [Contest] or [Deal] linked to [notification], or null.
  /// Fetched by id so contests that are upcoming, expired or inactive open too.
  Future<dynamic> openContentFromNotifications(
    AppNotification notification,
  ) async {
    try {
      final contestId = notification.contestId;
      if (contestId != null) {
        final contest = await _apiService.fetchContestById(contestId);
        AnalyticsService.logNotificationOpen(
          'Content',
          contest.id,
          contest.name,
        );
        return contest;
      }

      final dealId = notification.dealId;
      if (dealId != null) {
        final deal = await _apiService.fetchDealById(dealId);
        AnalyticsService.logNotificationOpen('Deal', deal.id, deal.name);
        return deal;
      }

      return null;
    } catch (e) {
      developer.log("Error opening content: $e");
      return null;
    }
  }

  Future<void> _openBox() async {
    _box = await Hive.openBox<AppNotification>(
      NotificationService.notificationsBoxName,
    );
    await _purgeDeletedNotifications();
    _subscription = _box!.watch().listen((event) {
      loadNotifications();
    });
    loadNotifications();
  }

  /// Drops entries the user already deleted but that came back on disk
  /// (written from a stale copy in the background isolate).
  Future<void> _purgeDeletedNotifications() async {
    final box = _box;
    if (box == null) return;
    final deletedIds = await NotificationService.loadDeletedIds();
    if (deletedIds.isEmpty) return;
    final keys = box.keys
        .where((key) => deletedIds.contains(box.get(key)?.id))
        .toList();
    if (keys.isNotEmpty) await box.deleteAll(keys);
  }

  /// Closes and re-opens the box so the main isolate sees what the background
  /// isolate wrote to disk. Concurrent calls share the same reload.
  Future<void> reloadFromDisk() {
    return _reloading ??= _reload().whenComplete(() => _reloading = null);
  }

  Future<void> _reload() async {
    await _subscription?.cancel();
    if (_box?.isOpen ?? false) {
      await _box!.close();
    }
    await _openBox();
  }
}
