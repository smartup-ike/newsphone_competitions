import 'package:flutter/material.dart';

import '../models/competition.dart';

class MyCompetitionTile extends StatelessWidget {
  final Competition competition;

  const MyCompetitionTile({super.key, required this.competition});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.favorite),
          Text(competition.title),
          Text(
            '${competition.endDate.day}/${competition.endDate.month}/${competition.endDate.year}',
          ),
        ],
      ),
    );
  }
}
