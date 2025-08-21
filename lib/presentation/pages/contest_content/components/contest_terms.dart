import 'package:flutter/material.dart';

class ContestTerms extends StatelessWidget {
  const ContestTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black),
        children: [
          const TextSpan(text: 'Δείτε τους Όρους Χρήσης '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'εδώ',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ),
          const TextSpan(text: ' | Γρ. Εξυπηρέτησης '),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                '2109472116',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
