import 'package:flutter/material.dart';
import 'package:newsphone_competitions/presentation/pages/contest_content/contest_shows_page.dart';
import '../../../core/functions/helper_functions.dart';
import '../../../data/models/contests.dart';
import '../terms_page/terms_page.dart';
import 'components/contest_appbar.dart';
import 'components/contest_details.dart';
import 'components/contest_header.dart';
import 'contest_callsms.dart';

class ContestContentPage extends StatelessWidget {
  final Contest contest;

  const ContestContentPage({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
                if (contest.shows.length == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ContestCallsms(
                            name: contest.name,
                            prefix: contest.shows.first.prefix,
                            contestId: contest.id,
                          ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContestShowsPage(contest: contest),
                    ),
                  );
                }
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
      ),
    );
  }
}
