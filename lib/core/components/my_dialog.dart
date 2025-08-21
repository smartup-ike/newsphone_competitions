import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDialog extends StatelessWidget {
  final String phoneNumber;
  final String message;

  const MyDialog({super.key, required this.phoneNumber, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('👉 Διάλεξε τρόπο'),
      content: Text(
        'Επέλεξε τρόπο συμμετοχής στον διαγωνισμό: κάλεσέ μας ή στείλε μήνυμα.',
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor:
                Theme.of(
                  context,
                ).colorScheme.inversePrimary, // Change text color to red
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            // Implement calling logic here
            _makePhoneCall();
          },
          icon: const Icon(Icons.phone),
          label: const Text('Καλέστε'),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor:
                Theme.of(
                  context,
                ).colorScheme.inversePrimary, // Change text color to red
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            // Implement messaging logic here
            _sendMessage();
          },
          icon: const Icon(Icons.sms),
          label: const Text('Στείλτε SMS'),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall() async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }

  Future<void> _sendMessage() async {
    final Uri smsUri = Uri.parse(
      'sms:$phoneNumber?body=${Uri.encodeComponent('$message ')}',
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }
}
