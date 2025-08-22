import 'package:flutter/material.dart';
import '../../../core/functions/helper_functions.dart';
import '../../../data/models/contests.dart';
import '../terms_page/terms_page.dart';
import 'components/bottom_modalsheet.dart';
import 'components/contest_appbar.dart';
import 'components/contest_details.dart';
import 'components/contest_header.dart';

class ContestContentPage extends StatelessWidget {
  final Content contest;

  const ContestContentPage({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ContestAppBar(title: contest.name),
          ContestHeader(imageUrl: contest.imageUrl),
          ContestDetails(
            contest: contest,
            buttonClick: () {
              showContestBottomSheet(
                context,
                () {
                  launchURL('tel:14614');
                },
                () {
                  final String messageBody = 'PO "Ονοματεπώνυμο"';
                  launchURL(
                    'sms:14614?body=${Uri.encodeComponent(messageBody)}',
                  );
                },
              );
            },
            onPressTermsButton: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsPage()),
              );
            },
            onPressWinnow: () {
              launchURL('https://winnow.gr');
            },
            onPressCallService: () {
              launchURL('tel:2109472116');
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
