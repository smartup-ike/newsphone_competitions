

import 'package:flutter/material.dart';

import '../../data/models/competition.dart';
import 'filter_box.dart';

class FavFilters extends StatelessWidget {
  const FavFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // Use Wrap to handle multiple checkboxes
      spacing: 8.0,
      alignment: WrapAlignment.center,
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
    );
  }
}
