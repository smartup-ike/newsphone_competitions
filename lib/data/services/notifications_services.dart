import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:newsphone_competitions/data/models/notification.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Request permissions (iOS)
    await _messaging.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    // Setup local notifications
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(initSettings);

    // ✅ Foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  static Future<void> showNotificationStatic(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  static void _handleMessage(RemoteMessage message) async {
    // 1️⃣ Show system notification
    await showNotificationStatic(message);

    // 2️⃣ Create AppNotification
    final appNotification = AppNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      timestamp: DateTime.now(),
      isRead: false,
      competitionId: message.data['competitionId'],
      endDate:
          message.data['endDate'] != null
              ? DateTime.tryParse(message.data['endDate'])
              : null,
    );

    // 3️⃣ Save to Hive
    var box = await Hive.openBox<AppNotification>('notifications');
    await box.add(appNotification);
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print("Subscribed to topic: $topic");
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print("Unsubscribed from topic: $topic");
  }
}
