import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../data/models/notification.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);
  final Box<AppNotification> _box = Hive.box<AppNotification>('notifications');

  NotificationCubit() : super([]) {
    // Load existing notifications from Hive
    emit(_box.values.toList());
  }

  void loadNotifications() {
    emit(_box.values.toList());
  }

  void addNotification(AppNotification notification) {
    _box.add(notification); // Save locally
    final newState = [...state, notification];
    emit(newState);
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
}
