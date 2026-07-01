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
                  "Σχετικά με την εφαρμογή 14614",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "Η εφαρμογή 14614 είναι ο πιο εύκολος και άμεσος τρόπος για να ενημερώνεσαι και να συμμετέχεις στους μοναδικούς διαγωνισμούς των εκπομπών του τηλεοπτικού σταθμού ΑΝΤ1. Μέσα από το app μπορείς να κερδίσεις απίθανα δώρα, να αξιοποιήσεις αποκλειστικές προσφορές και να κάνεις τις αγορές σου με προνομιακές τιμές, ειδικά για εσένα.",
                  style: NewsphoneTypography.body13Medium,
                ),
                const SizedBox(height: 24),
                Text(
                  "Πως λειτουργεί;",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "1. Σαρώνεις (scan) το QR Code που εμφανίζεται στην τηλεοπτική οθόνη ή εγκαθιστάς την εφαρμογή αναζητώντας «14614 app» στο Play Store ή στο App Store. .\n2. Συνδέεσαι με τον αριθμό του κινητού σου και λαμβάνεις 10 δωρεάν συμμετοχές ως καλωσόρισμα.\n3. Επιλέγεις έναν ενεργό διαγωνισμό και δηλώνεις συμμετοχή μέσω Κλήσης ή SMS, ακολουθώντας τα βήματα της εφαρμογής. ",
                  style: NewsphoneTypography.body13Medium,
                ),

                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Καλή επιτυχία!",
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
