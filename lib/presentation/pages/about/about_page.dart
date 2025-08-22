import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            floating: false,
            pinned: true,
            centerTitle: true,
            title: Text(
              'Σχετικά',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: Colors.grey[300], height: 1.0),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      height: 66, // Adjust height as needed
                      width: 225, // Optional: Adjust width as needed
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    "Τι είναι η εφαρμογή 14614;",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121212),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Η εφαρμογή 14614 είναι η επίσημη εφαρμογή για την τηλεοπτική εκπομπή “Το Πρωινό” του ΑΝΤ1. Μέσα από την εφαρμογή μπορείτε να συμμετέχετε σε μοναδικούς διαγωνισμούς και να κερδίζετε απίθανα δώρα!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333435),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Πως λειτουργεί;",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121212),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "1. Ανοίγετε την εφαρμογή 14614 και βλέπετε τους διαθέσιμους ενεργούς διαγωνισμούς.\n2. Επιλέγετε τον διαγωνισμό που σας ενδιαφέρει.\n3. Ακολουθείτε τα βήματα που περιγράφονται στην σελίδα του διαγωνισμού.\n4. Αγοράζετε μια δωροεπιταγή (giftcard).\n5. Με την αγορά της δωροεπιταγής συμμετέχετε αυτόματα στον διαγωνισμό για να κερδίσετε το μεγάλο δώρο που φαίνεται στη σελίδα του διαγωνισμού.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333435),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Που χρησιμοποιώ τη δωροεπιταγή;",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121212),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333435),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Η δωροεπιταγή που αγοράζετε εξαργυρώνεται στην ιστοσελίδα ',
                        ),
                        TextSpan(
                          text: 'winnow.gr',
                          style: const TextStyle(
                            color: Color(0xFF007AFF), // Blue color for the link
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: ', όπου μπορείτε να διαλέξετε προϊόντα.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Καλή επιτυχία και καλές αγορές!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333435),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}