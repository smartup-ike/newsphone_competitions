import 'package:flutter/material.dart';
import '../../../data/models/contests.dart';
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
              showContestBottomSheet(context);
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
