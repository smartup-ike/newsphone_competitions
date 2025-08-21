import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/provider/comp_provider.dart';
import '../../presentation/pages/fav_page.dart';

class FilterCheckbox extends StatelessWidget {
  final String type;
  final String name;

  const FilterCheckbox({super.key, required this.type, required this.name});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionsProvider>(context);
    final isSelected = provider.selectedFilters.contains(type);

    return FilterChip(
      label: Text(name),
      selected: isSelected,
      selectedColor: Colors.white,
      onSelected: (bool value) {
        provider.toggleFilter(type, value);
      },
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CompetitionsProvider(),
      child: MaterialApp(home: FavPage()),
    ),
  );
}
