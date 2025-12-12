import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

import '../../../../core/themes/newsphone_typography.dart';

class TermsContPage extends StatelessWidget {
  final String terms;

  const TermsContPage({super.key, required this.terms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsphoneTheme.neutralWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            title: Text(
              'Όροι & Προϋποθέσεις',
              style: NewsphoneTypography.body17Bold,
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: Colors.grey[300], height: 1.0),
            ),
          ),
          terms.isEmpty
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      terms.isEmpty
                          ? 'Δεν υπάρχουν όροι χρήσης & προϋποθέσεις'
                          : terms,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ),
              )
              : SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    terms,
                    style: TextStyle(fontSize: 14, height: 1.4),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
