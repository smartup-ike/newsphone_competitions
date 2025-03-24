import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_competition_tile.dart';
import 'package:newsphone_competitions/models/competition.dart';

class ListCompetition extends StatelessWidget {
  final List<Competition> competitions;

  const ListCompetition({super.key, required this.competitions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: ListView.builder(
        itemCount: competitions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MyCompetitionTile(
            competition: competitions[index],
            onTap:
                () => Navigator.pushNamed(
              context,
              '/info_page',
              arguments: competitions[index],
            ),
          );
        },
      ),
    );
  }
}
