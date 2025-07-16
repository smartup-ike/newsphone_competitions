import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_button.dart';
import 'package:newsphone_competitions/components/fav_filters.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/android12.png'),
                width: 300,
                height: 300,
              ),
              Text(
                'Καλώς ήρθατε στην εφαρμογή 14614',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
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
              const Text(
                'Η δωροεπιταγή που αγοράζετε εξαργυρώνεται στο site winnow.gr, όπου μπορείτε να διαλέξετε προϊόντα.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Καλή επιτυχία και καλές αγορές!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),
              Text(
                'Διαμορφώστε τα ενδιαφέροντά σας ανά πάσα στιγμή για να λαμβάνετε προτάσεις προσαρμοσμένες σε εσάς.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FavFilters(),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => Navigator.popAndPushNamed(context, '/main_page'),
                child: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
