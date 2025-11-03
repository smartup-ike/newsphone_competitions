import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  // FirebaseAnalytics singleton
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
    print('📊 ANALYTICS: Logged Event: $name with actions: $listActions');
  }

  /// 1️⃣ Log a topic subscription/unsubscription
  static Future<void> logTopicSubscription(
    String topicId,
    bool isSubscribing,
  ) async {
    final action = isSubscribing ? 'subscribe' : 'unsubscribe';

    // Log event in Firebase Analytics
    await _analytics.logEvent(
      name: 'topic_subscription',
      parameters: {'topic_id': topicId, 'action': action},
    );

    // Optional console log for dev
    print('📊 ANALYTICS: Logged Topic $action: $topicId');
  }

  /// 2️⃣ Log a communication action (Call/SMS)
  static Future<void> logAction(String actionType, String target) async {
    await _analytics.logEvent(
      name: 'communication_action',
      parameters: {'action_type': actionType, 'target': target},
    );

    print('📞 ANALYTICS: Logged Action: $actionType to $target');
  }

  /// 3️⃣ Log a notification content open
  static Future<void> logNotificationOpen(
    String contentType,
    int contentId,
  ) async {
    await _analytics.logEvent(
      name: 'notification_open',
      parameters: {'content_type': contentType, 'content_id': contentId},
    );

    print('🔔 ANALYTICS: Logged Notification Open: $contentType ID $contentId');
  }

  /// 4️⃣ Optional: Log screen view
  static Future<void> logScreenView(String screenName) async {
    await _analytics.logEvent(
      name: 'screen_view',
      parameters: {'screen_name': screenName},
    );

    print('🖥️ ANALYTICS: Logged Screen View: $screenName');
  }
}
