import 'package:flutter/material.dart';

// Reusable widget for a selectable category chip
class CustomActionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomActionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      labelStyle: TextStyle(
        color: isSelected ? Color(0xFF004079) : Colors.black87,
      ),
      avatar:
          isSelected
              ? const Icon(Icons.check, color: Color(0xFF004079), size: 16)
              : null,
      side: BorderSide(color: isSelected ? Color(0xFF004079) : Colors.grey),
      backgroundColor: isSelected ? Color(0XFFDEF8FF) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: onPressed,
    );
  }
}

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

  // A set to keep track of selected categories
  final Set<String> _selectedCategories = {'Οχήματα'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Προτιμήσεις διαγωνισμών',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              children:
                  categories.map((category) {
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
    );
  }
}
