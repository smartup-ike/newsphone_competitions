import 'package:flutter/material.dart';
import '../../../core/functions/helper_functions.dart';
import '../../../data/models/contests.dart';
import '../terms_page/terms_page.dart';
import 'components/bottom_modalsheet_callsms.dart';
import 'components/bottom_modalsheet_choosepro.dart';
import 'components/contest_appbar.dart';
import 'components/contest_details.dart';
import 'components/contest_header.dart';

class ContestContentPage extends StatelessWidget {
  final Contest contest;

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
              showContestChooseProBottomSheet(
                context,
                contest,
                () {
                  launchURL('tel:14614');
                },
                () {
                  // TODO : Here to change the first to letters from model
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
