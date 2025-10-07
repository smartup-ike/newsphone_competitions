import 'package:url_launcher/url_launcher.dart';

void launchURL(String stringURL) async {
  final Uri url = Uri.parse(stringURL);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void handleCall() {
  launchURL('tel:14614');
}

void handleSms(String prefix) {
  final messageBody = '$prefix ';
  launchURL('sms:14614?body=${Uri.encodeComponent(messageBody)}');
}
