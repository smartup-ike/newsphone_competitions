import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newsphone_competitions/data/models/notification.dart';
import 'package:newsphone_competitions/logic/blocs/notifications/notifications_cubit.dart';
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

  /// iOS does not always run the background handler, so a tapped push may not
  /// be in the box yet. Store it (de-duplicated by `notification_id`) before
  /// showing the list; NotificationsPage reloads the box from disk on open.
  static Future<void> _openFromMessage(RemoteMessage message) async {
    if (message.data['notification_id'] != null) {
      try {
        // Reload first so the de-dup check sees what the background isolate wrote.
        await navigatorKey.currentContext
            ?.read<NotificationCubit>()
            .reloadFromDisk();
        await storeRemoteMessage(message);
      } catch (e) {
        developer.log("Error storing opened notification: $e");
      }
    }
    _navigateToNotificationsPage();
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
      _openFromMessage(message);
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
        _openFromMessage(initialMessage);
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
    if (!_hasContent(message)) return;

    // Extract image URL from all possible FCM locations
    final imageUrl = imageUrlOf(message);

    NotificationDetails notificationDetails;

    if (imageUrl != null) {
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
      title: message.notification?.title ?? message.data['title'],
      body: message.notification?.body ?? message.data['body'],
      notificationDetails: notificationDetails,
    );
  }

  static void _handleMessage(RemoteMessage message) async {
    if (!_hasContent(message)) return;
    // 1️⃣ Show system notification
    await showNotificationStatic(message);
    // 2️⃣ Save to Hive (same isolate as NotificationCubit, so keep the box open)
    await storeRemoteMessage(message);
  }

  static const String notificationsBoxName = 'notifications';
  static const String _deletedIdsKey = 'deleted_notification_ids';
  static const int _maxDeletedIds = 300;

  static String? _nonEmpty(String? value) =>
      (value == null || value.isEmpty) ? null : value;

  static bool _hasContent(RemoteMessage message) =>
      _nonEmpty(message.notification?.title ?? message.data['title']) != null ||
      _nonEmpty(message.notification?.body ?? message.data['body']) != null;

  static String? imageUrlOf(RemoteMessage message) =>
      _nonEmpty(message.notification?.android?.imageUrl) ??
      _nonEmpty(message.notification?.apple?.imageUrl) ??
      _nonEmpty(message.data['image']) ??
      _nonEmpty(message.data['image_url']);

  /// Builds an [AppNotification] from the FCM payload. Reads the new keys
  /// (`contest_id`, `deal_id`, `notification_id`, ...) and falls back to the
  /// legacy `type`/`id` pair for pushes sent before the backend change.
  static AppNotification fromRemoteMessage(RemoteMessage message) {
    final data = message.data;
    final type = (data['type'] as String?) ?? '';
    final legacyId = int.tryParse(data['id'] ?? '');

    final contestId = int.tryParse(data['contest_id'] ?? '') ??
        (type == 'contest' ? legacyId : null);
    final dealId = int.tryParse(data['deal_id'] ?? '') ??
        (type == 'deal' ? legacyId : null);

    return AppNotification(
      id: int.tryParse(data['notification_id'] ?? '') ??
          DateTime.now().millisecondsSinceEpoch,
      title: message.notification?.title ?? data['title'] ?? '',
      body: message.notification?.body ?? data['body'] ?? '',
      topicName: data['topic_name'] ?? '',
      sentAt: message.sentTime ?? DateTime.now(),
      linkedContestId: contestId,
      linkedDealId: dealId,
      type: type,
      isRead: false,
      imageUrl: imageUrlOf(message),
    );
  }

  /// Saves [message] to the notifications box unless it is already stored or
  /// the user deleted it (matched by the backend `notification_id`).
  ///
  /// Pass [closeBox] from the background isolate: Hive is not multi-isolate
  /// safe, and a box left open there keeps a stale copy of entries the user
  /// later deletes in the main isolate.
  static Future<void> storeRemoteMessage(
    RemoteMessage message, {
    bool closeBox = false,
  }) async {
    if (!_hasContent(message)) return;

    final notification = fromRemoteMessage(message);
    final hasServerId =
        int.tryParse(message.data['notification_id'] ?? '') != null;

    final box = await Hive.openBox<AppNotification>(notificationsBoxName);
    try {
      // Explicit keys: auto-increment keys collide when two isolates add().
      final key = storageKey(notification.id);
      if (hasServerId) {
        final deletedIds = await loadDeletedIds();
        if (box.containsKey(key) || deletedIds.contains(notification.id)) {
          developer.log('Skipping duplicate notification ${notification.id}');
          return;
        }
      }
      await box.put(key, notification);
    } finally {
      if (closeBox) await box.close();
    }
  }

  static String storageKey(int notificationId) => 'n_$notificationId';

  /// Ids of notifications the user deleted, shared across isolates through
  /// SharedPreferences (reloaded so the background isolate sees fresh data).
  static Future<Set<int>> loadDeletedIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return (prefs.getStringList(_deletedIdsKey) ?? [])
        .map(int.tryParse)
        .whereType<int>()
        .toSet();
  }

  static Future<void> rememberDeletedIds(Iterable<int> ids) async {
    // id 0 comes from older app versions and is not unique.
    final newIds = ids.where((id) => id != 0);
    if (newIds.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final stored = prefs.getStringList(_deletedIdsKey) ?? [];
    final merged = {...stored, ...newIds.map((id) => id.toString())}.toList();
    final trimmed = merged.length > _maxDeletedIds
        ? merged.sublist(merged.length - _maxDeletedIds)
        : merged;
    await prefs.setStringList(_deletedIdsKey, trimmed);
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
    var box = Hive.box<AppNotification>(notificationsBoxName);
    // Here you can do any re-processing or mark them as unread
    developer.log('Loaded ${box.length} notifications on startup');
  }
}
