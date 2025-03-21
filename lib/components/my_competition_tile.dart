import 'package:flutter/material.dart';
import 'package:newsphone_competitions/functions/date_time_format.dart';

import '../models/competition.dart';

class MyCompetitionTile extends StatelessWidget {
  final Competition competition;
  final void Function() onTap;

  const MyCompetitionTile({
    super.key,
    required this.competition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(25),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    child: Image.asset(competition.imgPath),
                  ),
                ),

                const SizedBox(height: 25),
                Text(
                  competition.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                const SizedBox(height: 10),
                Text(
                  competition.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              'ΚΛΗΡΩΣΗ: ${formatDate(competition.endDate)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    DateTime.now().isBefore(competition.endDate)
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
