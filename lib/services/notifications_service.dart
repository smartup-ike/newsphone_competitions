import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setUpFlutterNotifications();
  await NotificationService.instance.showNotifications(message);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() async {
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission();
    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      log('FCM Token: $apnsToken');
    }
    await setUpFlutterNotifications();
    final token = await _messaging.getToken();
    log('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
  }

  Future<void> setUpFlutterNotifications() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    const channel = AndroidNotificationChannel(
      'hight_importance_channel',
      'Hight Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    const initilaizeSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final initilaizeSettings = InitializationSettings(
      android: initilaizeSettingsAndroid,
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotifications.initialize(
      initilaizeSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotifications(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'hight_importance_channel',
            'Hight Importance Notifications',
            channelDescription:
                'This channel is used for important notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  Future<void> setUpNotifications() async {
    FirebaseMessaging.onMessage.listen((message) {
      showNotifications(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_hanldeBackgroundMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _hanldeBackgroundMessage(initialMessage);
    }
  }

  void _hanldeBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // open chat screen
    }
  }
}
