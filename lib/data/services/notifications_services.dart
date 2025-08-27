import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart'; // Import DateFormat for custom parsing

import '../../logic/blocs/notifications/notifications_cubit.dart';
import '../models/notification.dart'; // Ensure correct import path for AppNotification

// Initialize FlutterLocalNotificationsPlugin for the background handler
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // --- FCM Setup ---
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }

    await _subscribeToTopic();

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


    // --- Local Notifications Setup ---
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          print('Local notification tapped: ${response.payload}');
        }
      },
    );

    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void listenForMessages(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('--- FCM Foreground Message Received ---');
      print('Message data: ${message.data}');
      print('Raw competitionId value from map: ${message.data['competitionId']?.runtimeType} -> ${message.data['competitionId']}');


      // Extract new data fields
      final String? competitionIdRaw = message.data['competitionId']?.toString(); // Ensure it's a string
      print('Extracted competitionIdRaw (after .toString()): $competitionIdRaw');

      DateTime? endDate;
      if (message.data['endDate'] != null) {
        try {
          // Explicitly parse with the expected format 'dd/MM/yyyy'
          endDate = DateFormat('dd/MM/yyyy').parse(message.data['endDate'].toString());
        } catch (e) {
          print('Error parsing endDate in onMessage: $e');
        }
      }
      print('Parsed endDate: $endDate');


      if (message.notification != null) {
        final appNotification = AppNotification(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
          timestamp: DateTime.now(),
          isRead: false,
          competitionId: competitionIdRaw, // Pass the extracted string
          endDate: endDate,             // Pass the parsed DateTime
        );
        context.read<NotificationCubit>().addNotification(appNotification);
        print('AppNotification created with competitionId: ${appNotification.competitionId}');
        print('AppNotification created with endDate: ${appNotification.endDate}');


        _flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription: 'This channel is used for important notifications.',
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: 'notification_id_${message.messageId}',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('--- FCM Message Opened App from Background ---');
      print('Message opened app from background: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Raw competitionId value from map: ${message.data['competitionId']?.runtimeType} -> ${message.data['competitionId']}');


      // Extract new data fields
      final String? competitionIdRaw = message.data['competitionId']?.toString(); // Ensure it's a string
      print('Extracted competitionIdRaw: $competitionIdRaw');

      DateTime? endDate;
      if (message.data['endDate'] != null) {
        try {
          // Explicitly parse with the expected format 'dd/MM/yyyy'
          endDate = DateFormat('dd/MM/yyyy').parse(message.data['endDate']);
        } catch (e) {
          print('Error parsing endDate in onMessageOpenedApp: $e');
        }
      }
      print('Parsed endDate: $endDate');

      if (message.notification != null) {
        final appNotification = AppNotification(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
          timestamp: DateTime.now(),
          isRead: false,
          competitionId: competitionIdRaw, // Pass the extracted string
          endDate: endDate,             // Pass the parsed DateTime
        );
        context.read<NotificationCubit>().addNotification(appNotification);
        print('AppNotification created with competitionId: ${appNotification.competitionId}');
        print('AppNotification created with endDate: ${appNotification.endDate}');
      }
      Navigator.pushNamed(context, '/notifications');
    });

    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('--- FCM App Opened from Terminated State ---');
        print('App opened from terminated state: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Raw competitionId value from map: ${message.data['competitionId']?.runtimeType} -> ${message.data['competitionId']}');


        // Extract new data fields
        final String? competitionIdRaw = message.data['competitionId']?.toString(); // Ensure it's a string
        print('Extracted competitionIdRaw: $competitionIdRaw');

        DateTime? endDate;
        if (message.data['endDate'] != null) {
          try {
            // Explicitly parse with the expected format 'dd/MM/yyyy'
            endDate = DateFormat('dd/MM/yyyy').parse(message.data['endDate']);
          } catch (e) {
            print('Error parsing endDate in getInitialMessage: $e');
          }
        }
        print('Parsed endDate: $endDate');

        if (message.notification != null) {
          final appNotification = AppNotification(
            title: message.notification!.title ?? 'No Title',
            body: message.notification!.body ?? 'No Body',
            timestamp: DateTime.now(),
            isRead: false,
            competitionId: competitionIdRaw, // Pass the extracted string
            endDate: endDate,             // Pass the parsed DateTime
          );
          context.read<NotificationCubit>().addNotification(appNotification);
          print('AppNotification created with competitionId: ${appNotification.competitionId}');
          print('AppNotification created with endDate: ${appNotification.endDate}');
        }
        Navigator.pushNamed(context, '/notifications');
      }
    });
  }
  static Future<void> _subscribeToTopic() async {
    // Get APNs token (iOS)
    String? apnsToken = await _messaging.getAPNSToken();

    if (apnsToken != null) {
      await _messaging.subscribeToTopic('14614competitions');
      print('Subscribed to topic: 14614competitions');
    } else {
      print('APNs token not yet available, waiting...');
      // Listen for token refresh
      _messaging.onTokenRefresh.listen((_) async {
        await _messaging.subscribeToTopic('14614competitions');
        print('Subscribed to topic after token refresh');
      });
    }
  }
}

// Background handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("--- FCM Background Message Handler ---");
  print("Handling a background message: ${message.messageId}");
  print("Message data: ${message.data}");
  print('Raw competitionId value from map in background: ${message.data['competitionId']?.runtimeType} -> ${message.data['competitionId']}');


  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Extract new data fields for background handler
  final String? competitionIdRaw = message.data['competitionId']?.toString(); // Ensure it's a string
  print('Extracted competitionIdRaw in background (after .toString()): $competitionIdRaw');

  DateTime? endDate;
  if (message.data['endDate'] != null) {
    try {
      // Explicitly parse with the expected format 'dd/MM/yyyy'
      endDate = DateFormat('dd/MM/yyyy').parse(message.data['endDate']);
    } catch (e) {
      print('Error parsing endDate in _firebaseMessagingBackgroundHandler: $e');
    }
  }
  print('Parsed endDate in background: $endDate');


  if (message.notification != null) {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: 'notification_id_${message.messageId}',
    );
  }
}