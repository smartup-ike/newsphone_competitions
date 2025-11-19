import 'package:flutter/material.dart';

import '../../../core/themes/newsphone_typography.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: CustomScrollView(
        slivers: [SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          floating: false,
          pinned: true,
          centerTitle: true,
          title: Text('Σχετικά', style: NewsphoneTypography.body17SemiBold),
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
                    'assets/images/logo.png',
                    height: 66,
                    width: 120,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  "Τι είναι η εφαρμογή 14614;",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "Η εφαρμογή 14614 είναι η επίσημη εφαρμογή για την τηλεοπτική εκπομπή “Το Πρωινό” του ΑΝΤ1. Μέσα από την εφαρμογή μπορείς να συμμετέχεις σε μοναδικούς διαγωνισμούς και να κερδίσεις απίθανα δώρα!",
                  style: NewsphoneTypography.body13Medium,
                ),
                const SizedBox(height: 24),
                Text(
                  "Πως λειτουργεί;",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "1. Ανοίγεις την εφαρμογή 14614 και βλέπεις τους διαθέσιμους ενεργούς διαγωνισμούς .\n2. Επιλέγεις τον διαγωνισμό που σε ενδιαφέρει .\n3. Ακολουθείς τα βήματα που περιγράφονται στην σελίδα του διαγωνισμού. \n4. Αγοράζεις μια δωροεπιταγή (giftcard).\n5. Με την αγορά της δωροεπιταγής συμμετέχεις αυτόματα στον διαγωνισμό για να κερδίσεις το μεγάλο δώρο που φαίνεται στη σελίδα του διαγωνισμού.",
                  style: NewsphoneTypography.body13Medium,
                ),
                const SizedBox(height: 24),
                Text(
                  "Που χρησιμοποιώ τη δωροεπιταγή;",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: NewsphoneTypography.body13Medium,
                    children: [
                      const TextSpan(
                        text:
                            'Η δωροεπιταγή που αγόρασες εξαργυρώνεται στην ιστοσελίδα ',
                      ),
                      TextSpan(
                        text: 'winnow.gr',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: ', όπου μπορείς να διαλέξετε προϊόντα.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Καλή επιτυχία και καλές αγορές!",
                    style: NewsphoneTypography.body15SemiBold,
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
