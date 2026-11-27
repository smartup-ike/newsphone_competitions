import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/sing_in_page.dart';

import '../../../core/themes/newsphone_typography.dart';

class CouponsInitialize extends StatelessWidget {
  const CouponsInitialize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.scaffoldMuted,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: NewsphoneTheme.surface,
            elevation: 0,
            floating: false,
            pinned: true,
            centerTitle: true,
            title: Text(
              'Οι δωρεάν συμμετοχές μου',
              style: NewsphoneTypography.body17SemiBold,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: NewsphoneTheme.divider, height: 1.0),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'SUPER ΠΡΟΣΦΟΡΑ!',
                    style: NewsphoneTypography.heading5Bold.copyWith(
                      color: NewsphoneTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    'Θέλετε να εξασφαλίσετε 10 ΔΩΡΕΑΝ συμμετοχές στους διαγωνισμούς μας;',
                    style: NewsphoneTypography.heading6Bold,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    'Με 10 δωρεάν συμμετοχές, δεκαπλασιάζετε τις πιθανότητες να κερδίσετε τα μεγάλα έπαθλα που προσφέρουν οι  διαγωνισμοί μας. Αρκεί μόνο ένα γρήγορο βήμα για να τα αποκτήσετε εντελώς δωρεάν.',
                    style: NewsphoneTypography.body13Regular,
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          // 1. Define the LinearGradient
                          gradient: LinearGradient(
                            colors: [NewsphoneTheme.gradientStart, NewsphoneTheme.gradientEnd],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "ΝΑΙ, θέλω 10 δωρεάν συμμετοχές!",
                            textAlign: TextAlign.center,
                            style: NewsphoneTypography.body17SemiBold.copyWith(
                              color: NewsphoneTheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
