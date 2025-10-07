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
              delegate: SliverChildListDelegate([
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your image path
                    height: 66, // Adjust height as needed
                    width: 120, // Optional: Adjust width as needed
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
                  "Η εφαρμογή 14614 είναι η επίσημη εφαρμογή για την τηλεοπτική εκπομπή “Το Πρωινό” του ΑΝΤ1. Μέσα από την εφαρμογή μπορείς να συμμετέχεις σε μοναδικούς διαγωνισμούς και να κερδίσεις απίθανα δώρα!",
                  style: TextStyle(fontSize: 14, color: Color(0xFF333435)),
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
                  "1. Ανοίγεις την εφαρμογή 14614 και βλέπεις τους διαθέσιμους ενεργούς διαγωνισμούς .\n2. Επιλέγεις τον διαγωνισμό που σε ενδιαφέρει .\n3. Ακολουθείς τα βήματα που περιγράφονται στην σελίδα του διαγωνισμού. \n4. Αγοράζεις μια δωροεπιταγή (giftcard).\n5. Με την αγορά της δωροεπιταγής συμμετέχεις αυτόματα στον διαγωνισμό για να κερδίσεις το μεγάλο δώρο που φαίνεται στη σελίδα του διαγωνισμού.",
                  style: TextStyle(fontSize: 14, color: Color(0xFF333435)),
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
                        text:
                            'Η δωροεπιταγή που αγόρασες εξαργυρώνεται στην ιστοσελίδα ',
                      ),
                      TextSpan(
                        text: 'winnow.gr',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(
                        text: ', όπου μπορείς να διαλέξετε προϊόντα.',
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
