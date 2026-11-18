import 'package:url_launcher/url_launcher.dart';

import '../../data/services/analytics_service.dart';
import 'package:newsphone_competitions/flavors/flavor_config.dart';

void launchURL(String stringURL) async {
  final Uri url = Uri.parse(stringURL);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

///Redirect to call this flavor's premium number
void handleCall(String showName) {
  launchURL('tel:${FlavorConfig.instance.phoneNumber}');
  AnalyticsService.logActionCallSMS('Call', showName);
}

///Redirect to send sms to this flavor's premium number with prefix
void handleSms(String prefix,String showName) {
  final messageBody = '$prefix ';

  launchURL('sms:${FlavorConfig.instance.phoneNumber}?body=${Uri.encodeComponent(messageBody)}');
  AnalyticsService.logActionCallSMS('SMS', showName);
}
