import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Logs a generic event with a list of actions
  static Future<void> basicLogEvent(
    String name,
    List<String> listActions,
  ) async {
    // Convert list to numbered keys to keep Firebase Analytics happy
    final params = <String, Object>{};
    for (var i = 0; i < listActions.length; i++) {
      params['action_$i'] = listActions[i];
    }

    // Log the event
    await _analytics.logEvent(name: name, parameters: params);

    // Optional dev log
    if (kDebugMode) {
      print('📊 ANALYTICS: Logged Event: $name with actions: $listActions');
    }
  }

  /// Logs even when open deal or content
  static Future<void> logOpenContentDeal(
    String id,
    String name,
    bool isContent,
  ) async {
    // Log event in Firebase Analytics
    await _analytics.logEvent(
      name: isContent ? 'open_content' : 'open_deal',
      parameters: {'id': id, 'name': name},
    );

    if (kDebugMode) {
      print(
        '📊 ANALYTICS: Logged Open ${isContent ? 'Content' : 'Deal'}: $id, $name ',
      );
    }
  }

  /// Log a communication action (Call/SMS)
  static Future<void> logActionCallSMS(
    String actionType,
    String showName,
  ) async {
    await _analytics.logEvent(
      name: 'communication_action',
      parameters: {
        'action_type': actionType,
        'show_name': showName,
      },
    );

    if (kDebugMode) {
      print(
        '📞 ANALYTICS: Logged Action: $actionType. Show name: ($showName)',
      );
    }
  }

  /// Log copy of deal code
  static Future<void> logCopyDealCode(String dealName) async {
    await _analytics.logEvent(
      name: 'copy_action',
      parameters: {'deal_name': dealName},
    );

    if (kDebugMode) {
      print('📊 ANALYTICS: Logged Action Copy code: $dealName');
    }
  }

  /// Log open Content/Deal content from Notification
  static Future<void> logNotificationOpen(
    String type,
    String id,
    String name,
  ) async {
    await _analytics.logEvent(
      name: 'user_notification_open',
      parameters: {'type': type, 'id': id, 'name': name},
    );
    if (kDebugMode) {
      print(
        '🔔 ANALYTICS: Logged Notification Open: $type ID: $id Name: $name',
      );
    }
  }

  /// Log a topic subscription/unsubscription
  static Future<void> logTopicSubscription(
    String topicName,
    bool isSubscribing,
  ) async {
    final action = isSubscribing ? 'subscribe' : 'unsubscribe';

    // Log event in Firebase Analytics
    await _analytics.logEvent(
      name: 'topic_subscription',
      parameters: {'topic_name': topicName, 'action': action},
    );

    if (kDebugMode) {
      print('📊 ANALYTICS: Logged Topic $action: $topicName');
    }
  }

  /// Log subscription/unsubscription to all
  static Future<void> logTopicSubscriptionAll(
      bool isSubscribing,
      ) async {
    final action = isSubscribing ? 'subscribe' : 'unsubscribe';

    // Log event in Firebase Analytics
    await _analytics.logEvent(
      name: 'subscription_all_topics',
      parameters: {'action': action},
    );

    if (kDebugMode) {
      print('📊 ANALYTICS: Logged to all Topic $action');
    }
  }
}
