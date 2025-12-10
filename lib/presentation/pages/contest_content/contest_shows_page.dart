import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/data/models/contests.dart';
import 'package:newsphone_competitions/presentation/pages/contest_content/contest_callsms.dart';

import '../../../core/themes/newsphone_typography.dart';
import 'components/program_button.dart';

class ContestShowsPage extends StatefulWidget {
  final Contest contest;

  const ContestShowsPage({super.key, required this.contest});

  @override
  State<ContestShowsPage> createState() => _ContestShowsPageState();
}

class _ContestShowsPageState extends State<ContestShowsPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: NewsphoneTheme.neutralWhite,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              floating: false,
              pinned: true,
              centerTitle: true,
              title: Text(
                'Επιλογή Εκπομπής',
                style: NewsphoneTypography.body17SemiBold,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(color: Colors.grey[300], height: 1.0),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Μέσω ποιας εκπομπής θέλεις να συμμετέχεις στο διαγωνισμό;',
                      textAlign: TextAlign.center,
                      style: NewsphoneTypography.heading6Bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Επίλεξε την εκπομπή που παρακολουθείς και στης οποίας το διαγωνισμό θέλεις να πάρεις μέρος',
                      textAlign: TextAlign.center,
                      style: NewsphoneTypography.body13Regular,
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(widget.contest.shows.length, (
                      index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        child: ProgramButton(
                          label: widget.contest.shows[index].name,
                          selected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ContestCallsms(
                                      name: widget.contest.name,
                                      prefix:
                                          widget.contest.shows[index].prefix,
                                      contestId: widget.contest.id,
                                    ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
