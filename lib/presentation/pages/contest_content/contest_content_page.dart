import 'package:flutter/material.dart';
import 'package:newsphone_competitions/presentation/pages/contest_content/contest_shows_page.dart';
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
          //App bar with the title name
          ContestAppBar(title: contest.name),

          //Contest header the images etc.
          ContestHeader(images: contest.images),

          //The rest details.
          ContestDetails(
            contest: contest,
            buttonClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ContestShowsPage(contest: contest)),
              );
              // if (contest.shows.length == 1) {
              //   showContestPhoneSmsBottomSheet(
              //     context,
              //     () => handleCall(contest.shows.first.name),
              //     () => handleSms(
              //       contest.shows.first.prefix,
              //       contest.shows.first.name,
              //     ),
              //   );
              // } else {
              //   showContestChooseProBottomSheet(
              //     context,
              //     contest,
              //     (String name) => handleCall(name),
              //     (String prefix, String name) => handleSms(prefix, name),
              //   );
              // }
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
          const SliverToBoxAdapter(child: SizedBox(height: 70)),
        ],
      ),
    );
  }
}
