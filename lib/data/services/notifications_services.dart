import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

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

    // On iOS, we might need to wait for the APNS token to be available
    // before calling getToken(). We wrap it in a try-catch to avoid crashing.
    try {
      if (Platform.isIOS) {
        // Give it a moment to receive the APNS token
        await Future.delayed(const Duration(seconds: 1));
      }
      String? token = await _messaging.getToken();
      developer.log("FCM Token: $token");
    } catch (e) {
      developer.log("Error getting FCM token: $e");
    }

    // Setup local notifications
    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(settings: initSettings);

    // ✅ Foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  static Future<void> showNotificationStatic(RemoteMessage message) async {
    if ((message.notification?.title ?? '').isEmpty &&
        (message.notification?.body ?? '').isEmpty) {
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: message.notification.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
    );
  }

  static void _handleMessage(RemoteMessage message) async {
    if ((message.notification?.title ?? '').isEmpty &&
        (message.notification?.body ?? '').isEmpty) {
      return;
    }
    // 1️⃣ Show system notification
    await showNotificationStatic(message);
    // 🔹 Print the RemoteMessage object
    // print('--- RemoteMessage ---');
    // print('Message ID: ${message.messageId}');
    // print('Title: ${message.notification?.title}');
    // print('Body: ${message.notification?.body}');
    // print('Data: ${message.data}');
    // print('From: ${message.from}');
    // print('Sent time: ${message.sentTime}');
    // print('--- End RemoteMessage ---');

    // 2️⃣ Create AppNotification
    final appNotification = AppNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      topicName: message.data['topic_name'] ?? '',
      sentAt: DateTime.now(),
      id: int.tryParse(message.messageId ?? '') ?? 0,
      linkedContestId: int.tryParse(message.data['id'] ?? '') ?? 0,
      linkedDealId: int.tryParse(message.data['id'] ?? ''),
      type: message.data['type'] ?? '',
      isRead: false,
    );

    // 3️⃣ Save to Hive
    var box = await Hive.openBox<AppNotification>('notifications');
    await box.add(appNotification);
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    developer.log("Subscribed to topic: $topic");
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    developer.log("Unsubscribed from topic: $topic");
  }

  static Future<void> loadMissedNotifications() async {
    var box = Hive.box<AppNotification>('notifications');
    // Here you can do any re-processing or mark them as unread
    developer.log('Loaded ${box.length} notifications on startup');
  }
}
