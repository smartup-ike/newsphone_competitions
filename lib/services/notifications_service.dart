import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission();
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      if (Platform.isIOS) {
        final apnsToken = await _messaging.getAPNSToken();
        log('FCM Token: $apnsToken');
      }
      final token = await _messaging.getToken();
      log('FCM Token: $token');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("❌ User denied notifications.");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log("⚠️ User granted provisional permissions (iOS only).");
    }
  }
}
