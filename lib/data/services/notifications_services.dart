import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:newsphone_competitions/data/models/notification.dart';
import 'package:newsphone_competitions/presentation/pages/notifications/notification_page.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static DateTime? _lastNavigationTime;

  static void _navigateToNotificationsPage() {
    final now = DateTime.now();
    if (_lastNavigationTime != null &&
        now.difference(_lastNavigationTime!) < const Duration(milliseconds: 1000)) {
      developer.log("Skipping duplicate notification navigation");
      return;
    }
    _lastNavigationTime = now;

    developer.log("Navigating to NotificationsPage...");
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const NotificationsPage(),
      ),
    );
  }

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
    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        developer.log("Local notification clicked: ${response.payload}");
        _navigateToNotificationsPage();
      },
    );

    // ✅ Foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // ✅ Background / Terminated message callbacks opened app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log("FCM Notification opened app: ${message.messageId}");
      _navigateToNotificationsPage();
    });
  }

  static bool _initialNotificationHandled = false;

  static Future<void> handleInitialNotification() async {
    if (_initialNotificationHandled) return;
    _initialNotificationHandled = true;

    try {
      final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        developer.log("App opened from terminated state via FCM: ${initialMessage.messageId}");
        _navigateToNotificationsPage();
        return;
      }
    } catch (e) {
      developer.log("Error checking initial FCM message: $e");
    }

    try {
      final NotificationAppLaunchDetails? launchDetails =
          await _localNotifications.getNotificationAppLaunchDetails();
      if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
        developer.log("App opened from terminated state via local notification");
        _navigateToNotificationsPage();
      }
    } catch (e) {
      developer.log("Error checking local notification launch details: $e");
    }
  }

  /// Downloads an image from [url] and saves it as a temp file.
  /// Returns the file path, or null if the download fails.
  static Future<String?> _downloadImageToTemp(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return null;
      final dir = await getTemporaryDirectory();
      final ext = url.contains('.png') ? 'png' : 'jpg';
      final file = File('${dir.path}/notification_image_${DateTime.now().millisecondsSinceEpoch}.$ext');
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } catch (e) {
      developer.log('Failed to download notification image: $e');
      return null;
    }
  }

  static Future<void> showNotificationStatic(RemoteMessage message) async {
    if ((message.notification?.title ?? '').isEmpty &&
        (message.notification?.body ?? '').isEmpty) {
      return;
    }

    // Extract image URL from all possible FCM locations
    final imageUrl = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        message.data['image'] ??
        message.data['image_url'];

    NotificationDetails notificationDetails;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final imagePath = await _downloadImageToTemp(imageUrl);

      if (imagePath != null) {
        if (Platform.isAndroid) {
          final bigPictureStyle = BigPictureStyleInformation(
            FilePathAndroidBitmap(imagePath),
            largeIcon: FilePathAndroidBitmap(imagePath),
            contentTitle: message.notification?.title,
            summaryText: message.notification?.body,
            hideExpandedLargeIcon: false,
          );
          final androidDetails = AndroidNotificationDetails(
            'default_channel',
            'General Notifications',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyle,
            largeIcon: FilePathAndroidBitmap(imagePath),
          );
          notificationDetails = NotificationDetails(android: androidDetails);
        } else if (Platform.isIOS) {
          final attachment = DarwinNotificationAttachment(imagePath);
          final iosDetails = DarwinNotificationDetails(
            attachments: [attachment],
          );
          notificationDetails = NotificationDetails(iOS: iosDetails);
        } else {
          notificationDetails = const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel',
              'General Notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          );
        }
      } else {
        // Image download failed — fall back to plain notification
        notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'General Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        );
      }
    } else {
      // No image — plain notification
      notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
    }

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

    final imageUrl = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        message.data['image'] ??
        message.data['image_url'];

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
      imageUrl: imageUrl,
    );

    // 3️⃣ Save to Hive
    var box = await Hive.openBox<AppNotification>('notifications');
    await box.add(appNotification);
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      developer.log("Subscribed to topic: $topic");
    } catch (e) {
      developer.log("Error subscribing to topic $topic: $e");
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      developer.log("Unsubscribed from topic: $topic");
    } catch (e) {
      developer.log("Error unsubscribing from topic $topic: $e");
    }
  }

  static Future<void> loadMissedNotifications() async {
    var box = Hive.box<AppNotification>('notifications');
    // Here you can do any re-processing or mark them as unread
    developer.log('Loaded ${box.length} notifications on startup');
  }
}
