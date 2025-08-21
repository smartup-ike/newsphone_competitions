import 'package:flutter/material.dart';

class ContestPrices extends StatelessWidget {
  const ContestPrices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 14, color: Color(0xFF555758)),
            children: [
              TextSpan(text: 'Σταθερό '),
              TextSpan(
                text: '3,14 €',
                style: TextStyle(
                  color: Color(0xFFED1953),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: ' / ΚΛΗΣΗ με ΦΠΑ'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 14, color: Color(0xFF555758)),
            children: [
              TextSpan(text: 'Κινητό '),
              TextSpan(
                text: '3,29 €',
                style: TextStyle(
                  color: Color(0xFFED1953),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: ' / ΚΛΗΣΗ - SMS με ΦΠΑ'),
            ],
          ),
        ),
      ],
    );
  }
}
