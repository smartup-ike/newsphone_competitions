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

///Redirect to call the 14614
void handleCall() {
  launchURL('tel:14614');
}

///Redirect to send sms to the 14614 with prefix
void handleSms(String prefix) {
  final messageBody = '$prefix ';


  launchURL('sms:14614?body=${Uri.encodeComponent(messageBody)}');
}
