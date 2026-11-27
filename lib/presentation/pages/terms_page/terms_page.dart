import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

import '../../../flavors/flavor_config.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool isGreek = true;

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
              isGreek ? 'Όροι χρήσης' : 'Terms of Use',
              style: NewsphoneTypography.body16Bold,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.language, color: NewsphoneTheme.textStrong),
                tooltip: 'Switch language',
                onPressed: () {
                  setState(() {
                    isGreek = !isGreek;
                  });
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              // Height of the divider
              child: Container(
                color: NewsphoneTheme.divider,
                height: 1.0,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                isGreek
                    ? [for (var term in FlavorConfig.instance.greekTerms()) term]
                    : [for (var term in FlavorConfig.instance.englishTerms()) term],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
