import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsphone_competitions/data/models/contests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constans/constants.dart';
import '../../../data/models/categories.dart';
import '../../../data/models/notification.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/notifications_services.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);

  // Use a late final box
  late final Box<AppNotification> _box;
  late StreamSubscription<BoxEvent> _subscription;

  // Keep track of selected topic IDs
  Set<String> _selectedTopics = {};

  Set<String> get selectedTopics => _selectedTopics;

  NotificationCubit() : super([]) {
    _init();
  }

  // ! It will fetch letter by api
  final List<Category> categories = [
    Category(title: 'Οχήματα', topicId: 'vehiclesTopic'),
    Category(title: 'Κινητά', topicId: 'mobilesTopic'),
    Category(title: 'Χρήματα', topicId: 'moneyTopic'),
    Category(title: 'Ψώνια', topicId: 'shoppingTopic'),
    Category(title: 'Ταξίδια', topicId: 'travelTopic'),
  ];

  void _init() async {
    _box = await Hive.openBox<AppNotification>('notifications');
    // Listen for changes to the box
    _subscription = _box.watch().listen((event) {
      loadNotifications();
    });
    // Load initial notifications
    loadNotifications();

    // Load saved topics from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    _selectedTopics = (prefs.getStringList('selectedTopics') ?? []).toSet();

    // Ensure default topic if none selected
    if (_selectedTopics.isEmpty) {
      _selectedTopics.add(defaultTopic);
    }

    await _subscribeToTopics(_selectedTopics);
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

  Future<void> toggleTopic(String topicId) async {
    // Cache SharedPreferences instance somewhere else if possible
    final prefs = await SharedPreferences.getInstance();

    final List<Future<void>> tasks = [];

    if (_selectedTopics.contains(topicId)) {
      // Remove topic
      _selectedTopics.remove(topicId);
      tasks.add(NotificationService.unsubscribeFromTopic(topicId));
    } else {
      // Add topic
      _selectedTopics.add(topicId);
      tasks.add(NotificationService.subscribeToTopic(topicId));
    }

    // Ensure at least default topic is subscribed
    if (_selectedTopics.isEmpty) {
      _selectedTopics.add(defaultTopic);
      tasks.add(NotificationService.subscribeToTopic(defaultTopic));
    } else if (_selectedTopics.contains(defaultTopic) &&
        _selectedTopics.length > 1) {
      _selectedTopics.remove(defaultTopic);
      tasks.add(NotificationService.unsubscribeFromTopic(defaultTopic));
    }

    // Run all subscriptions/unsubscriptions in parallel
    await Future.wait(tasks);

    // Save updated topics
    await prefs.setStringList('selectedTopics', _selectedTopics.toList());

    emit(List.from(state));
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

    emit(List.from(state));
  }

  Future<Contest?> openContentFromNotifications(String? id) async {
    final apiService = ApiService();

    try {
      // 1. Fetch all contests
      final contests = await apiService.fetchContests();

      // 2. Find the contest that matches the notification ID
      final contest = contests.firstWhere(
        (c) => c.id == id,
        orElse: () => throw Exception('Contest not found'),
      );

      return contest;
    } catch (e) {
      developer.log("Error opening contest content: $e");
      return null;
    }
  }
}
