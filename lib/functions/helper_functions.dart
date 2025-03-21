import 'package:url_launcher/url_launcher.dart';

void launchURL(String stringURL) async {
  final Uri url = Uri.parse(stringURL);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}