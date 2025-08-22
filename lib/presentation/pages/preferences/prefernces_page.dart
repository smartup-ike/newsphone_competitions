import 'package:flutter/material.dart';

import 'components/custom_action_chip.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final List<String> categories = [
    'Οχήματα',
    'Κινητά',
    'Χρήματα',
    'Ψώνια',
    'Ταξίδια',
  ];

  final Set<String> _selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            floating: false,
            pinned: true,
            centerTitle: true,
            title: Text(
              'Προτιμήσεις διαγωνισμών',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey[300],
                height: 1.0,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 24),
                  const Text(
                    "Τι κατηγορίες διαγωνισμών σας ενδιαφέρουν;",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121212),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Επιλέξτε τις κατηγορίες διαγωνισμών για τους οποίους θέλετε να λαμβάνετε ειδοποιήσεις.",
                    style: TextStyle(fontSize: 13, color: Color(0xFF333435)),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: categories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return CustomActionChip(
                        label: category,
                        isSelected: isSelected,
                        onPressed: () {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.remove(category);
                            } else {
                              _selectedCategories.add(category);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}