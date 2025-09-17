import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../data/models/notification.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);

  // Use a late final box
  late final Box<AppNotification> _box;
  late StreamSubscription<BoxEvent> _subscription;

  NotificationCubit() : super([]) {
    _init();
  }

  void _init() async {
    _box = await Hive.openBox<AppNotification>('notifications');
    // Listen for changes to the box
    _subscription = _box.watch().listen((event) {
      loadNotifications();
    });
    // Load initial notifications
    loadNotifications();
  }

  void loadNotifications() {
    emit(_box.values.toList());
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
    final newState = state.map((notification) {
      if (!notification.isRead) {
        notification.isRead = true;
        notification.save(); // update Hive
      }
      return notification;
    }).toList();
    emit(newState);
  }

  void markNotificationAsRead(AppNotification notificationToMark) {
    final newState = state.map((notification) {
      if (notification.key == notificationToMark.key && !notification.isRead) {
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
}
