import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _messaging.requestPermission();
    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      log('FCM Token: $apnsToken');
    }
    final token = await _messaging.getToken();
    log('FCM Token: $token');
  }
}
