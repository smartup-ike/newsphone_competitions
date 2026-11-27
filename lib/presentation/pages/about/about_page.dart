import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

import '../../../core/themes/newsphone_typography.dart';
import 'package:newsphone_competitions/flavors/flavor_config.dart';
import 'package:newsphone_competitions/presentation/widgets/flavor_logo.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.scaffoldMuted,
      body: CustomScrollView(
        slivers: [SliverAppBar(
          backgroundColor: NewsphoneTheme.surface,
          elevation: 0,
          floating: false,
          pinned: true,
          centerTitle: true,
          title: Text('Σχετικά', style: NewsphoneTypography.body17SemiBold),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: NewsphoneTheme.divider, height: 1.0),
          ),
        ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Align(
                  alignment: Alignment.center,
                  child: FlavorLogo(
                    FlavorConfig.instance.appLogoAsset,
                    height: 66,
                    width: 120,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  "Σχετικά με την εφαρμογή ${FlavorConfig.instance.appName}",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "Η εφαρμογή ${FlavorConfig.instance.appName} είναι ο πιο εύκολος και άμεσος τρόπος για να ενημερώνεσαι και να συμμετέχεις στους μοναδικούς διαγωνισμούς των εκπομπών του τηλεοπτικού σταθμού ${FlavorConfig.instance.stationName}. Μέσα από το app μπορείς να κερδίσεις απίθανα δώρα, να αξιοποιήσεις αποκλειστικές προσφορές και να κάνεις τις αγορές σου με προνομιακές τιμές, ειδικά για εσένα.",
                  style: NewsphoneTypography.body13Medium,
                ),
                const SizedBox(height: 24),
                Text(
                  "Πως λειτουργεί;",
                  style: NewsphoneTypography.heading7Bold,
                ),
                const SizedBox(height: 8),
                Text(
                  "1. Σαρώνεις (scan) το QR Code που εμφανίζεται στην τηλεοπτική οθόνη ή εγκαθιστάς την εφαρμογή αναζητώντας «${FlavorConfig.instance.appName} app» στο Play Store ή στο App Store. .\n2. Συνδέεσαι με τον αριθμό του κινητού σου και λαμβάνεις 10 δωρεάν συμμετοχές ως καλωσόρισμα.\n3. Επιλέγεις έναν ενεργό διαγωνισμό και δηλώνεις συμμετοχή μέσω Κλήσης ή SMS, ακολουθώντας τα βήματα της εφαρμογής. ",
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
