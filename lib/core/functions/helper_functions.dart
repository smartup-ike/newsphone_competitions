import 'package:url_launcher/url_launcher.dart';

import '../../data/services/analytics_service.dart';
import '../../data/services/brand_service.dart';

void launchURL(String stringURL) async {
  final Uri url = Uri.parse(stringURL);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

///Redirect to call this app's premium number (from the backend, see BrandService)
void handleCall(String showName) {
  launchURL('tel:${BrandService.current.callNumber}');
  AnalyticsService.logActionCallSMS('Call', showName);
}

///Redirect to send sms to this app's SMS number with prefix
void handleSms(String prefix,String showName) {
  final messageBody = '$prefix ';

  launchURL('sms:${BrandService.current.smsNumber}?body=${Uri.encodeComponent(messageBody)}');
  AnalyticsService.logActionCallSMS('SMS', showName);
}
