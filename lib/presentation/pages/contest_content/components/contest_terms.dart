import 'package:flutter/material.dart';

class ContestTerms extends StatelessWidget {
  final VoidCallback onPressTermsButton;
  final VoidCallback onPressCallService;

  const ContestTerms({
    super.key,
    required this.onPressTermsButton,
    required this.onPressCallService,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black),
        children: [
          const TextSpan(text: 'Δες τους Όρους Χρήσης '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: onPressTermsButton,
              child: const Text(
                'εδώ',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ),
          const TextSpan(text: ' | Δωροεπιταγή για όλους από το winnow.gr'),
          const TextSpan(text: ' | Γρ. Εξυπηρέτησης 2109472116'),
        ],
      ),
    );
  }
}
