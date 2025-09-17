import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/notification.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static final StreamController<AppNotification> _notificationStreamController =
  StreamController.broadcast();
  static Stream<AppNotification> get notificationStream =>
      _notificationStreamController.stream;

  static Future<void> init() async {
    // Request permissions (iOS)
    await _messaging.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    // Setup local notifications
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit,iOS: iosInit);
    await _localNotifications.initialize(initSettings);

    // ✅ Foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // ✅ Background & Terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void _handleMessage(RemoteMessage message) {
    // 1️⃣ Show system notification
    _showNotification(message);

    // 2️⃣ Push notification to app stream
    final appNotification = AppNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      timestamp: DateTime.now(),
      isRead: false,
      competitionId: message.data['competitionId'],
      endDate: message.data['endDate'],
    );

    _notificationStreamController.add(appNotification);
  }

  static Future<void> _showNotification(RemoteMessage message) async {
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
}

// Background handler (must be top-level function)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService._showNotification(message);
}
