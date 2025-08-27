// In lib/logic/blocs/notifications/notifications_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/notification.dart';

class NotificationCubit extends Cubit<List<AppNotification>> {
  NotificationCubit() : super([]);

  // Getter to check if there are any unread notifications
  bool get hasUnreadNotifications =>
      state.any((notification) => !notification.isRead);

  void addNotification(AppNotification notification) {
    final newState = [...state, notification];
    emit(newState);
  }

  // Method to mark all notifications as read
  void markAllAsRead() {
    final newState =
        state.map((notification) {
          if (!notification.isRead) {
            return AppNotification(
              title: notification.title,
              body: notification.body,
              timestamp: notification.timestamp,
              isRead: true,
              competitionId: notification.competitionId,
              endDate: notification.endDate,
            );
          }
          return notification;
        }).toList();
    emit(newState);
  }

  // Optional: Mark a single notification as read (if you want more granular control)
  void markNotificationAsRead(AppNotification notificationToMark) {
    final newState =
        state.map((notification) {
          if (notification.title == notificationToMark.title &&
              notification.body == notificationToMark.body &&
              !notification.isRead) {
            // Add other unique identifiers if available
            return AppNotification(
              title: notification.title,
              body: notification.body,
              timestamp: notification.timestamp,
              isRead: true,

              competitionId: notification.competitionId,
              endDate: notification.endDate,
            );
          }
          return notification;
        }).toList();
    emit(newState);
  }
}
