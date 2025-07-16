import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Σχετικά',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/android12.png', height: 300, width: 300),
            // Τίτλος
            const Text(
              'Τι είναι η εφαρμογή 14614;',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Περιγραφή
            const Text(
              'Η εφαρμογή 14614 είναι η επίσημη εφαρμογή για την τηλεοπτική εκπομπή "Το Πρωινό" του ANT1. '
              'Μέσα από την εφαρμογή μπορείτε να συμμετέχετε σε μοναδικούς διαγωνισμούς και να απίθανα δώρα!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Πώς λειτουργεί;',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '1️⃣ Ανοίγετε την εφαρμογή 14614 και βλέπετε τους διαθέσιμους διαγωνισμούς.\n\n'
              '2️⃣ Επιλέγετε τον διαγωνισμό που σας ενδιαφέρει.\n\n'
              '3️⃣ Ακολουθείτε τα βήματα που περιγράφονται στην σελίδα του διαγωνισμού.\n\n'
              '4️⃣ Αγοράζετε μια δωροεπιταγή (gift card).\n\n'
              '5️⃣ Με την αγορά της δωροεπιταγής συμμετέχετε αυτόματα στον διαγωνισμό για να κερδίσετε το μεγάλο δώρο που φαίνεται στη σελίδα του διαγωνισμού!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Πού χρησιμοποιείτε τη δωροεπιταγή;',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  const TextSpan(
                    text: 'Η δωροεπιταγή που αγοράζετε εξαργυρώνεται στο site ',
                  ),
                  TextSpan(
                    text: 'winnow.gr',
                    style: const TextStyle(color: Colors.blue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () async {
                            final url = Uri.parse('https://www.winnow.gr');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              // Προαιρετικά: εμφάνισε μήνυμα σφάλματος
                            }
                          },
                  ),
                  const TextSpan(
                    text: ', όπου μπορείτε να διαλέξετε προϊόντα.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Καλή επιτυχία και καλές αγορές!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
