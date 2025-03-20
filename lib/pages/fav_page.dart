import 'package:flutter/material.dart';

import '../components/filter_box.dart';
import '../models/competition.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Τι κατηγορίες διαγωνισμών σε ενδιαφέρουν;',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Διάλεξέ τες για να βλέπεις αυτές που σε ενδιαφέρουν.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Wrap(
                // Use Wrap to handle multiple checkboxes
                spacing: 8.0,
                children: [
                  FilterCheckbox(
                    type: CompetitionType.vehicle.toString(),
                    name: 'Αυτοκινητα',
                  ),
                  FilterCheckbox(
                    type: CompetitionType.phone.toString(),
                    name: 'Κινητά',
                  ),
                  FilterCheckbox(
                    type: CompetitionType.money.toString(),
                    name: 'Χρήματα',
                  ),
                  FilterCheckbox(
                    type: CompetitionType.shopping.toString(),
                    name: 'Ψώνια',
                  ),
                  FilterCheckbox(
                    type: CompetitionType.trip.toString(),
                    name: 'Ταξίδια',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
