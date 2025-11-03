import 'package:url_launcher/url_launcher.dart';

import '../../data/services/analytics_service.dart';

void launchURL(String stringURL) async {
  final Uri url = Uri.parse(stringURL);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void handleCall() {
  // 📞 ANALYTICS CALL 4: Log Call action
  AnalyticsService.logAction('call', '14614');
  launchURL('tel:14614');
}

void handleSms(String prefix) {
  final messageBody = '$prefix ';

  // 📞 ANALYTICS CALL 4: Log Call action
  AnalyticsService.logAction('sms', '14614');

  launchURL('sms:14614?body=${Uri.encodeComponent(messageBody)}');
}
