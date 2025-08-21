import 'package:flutter/material.dart';

class ContestInstructions extends StatelessWidget {
  const ContestInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Οδηγίες Συμμετοχής:',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ΚΑΛΕΣΤΕ ΑΠΟ ΣΤΑΘΕΡΟ Ή ΚΙΝΗΤΟ ΣΤΟ',
          style: TextStyle(fontSize: 15),
        ),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 15, color: Colors.black),
            children: [
              TextSpan(
                text: '14614 ',
                style: TextStyle(
                  color: Color(0xFFED1953),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: 'ΑΦΗΣΤΕ '),
              TextSpan(
                text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ',
                style: TextStyle(
                  color: Color(0xFFED1953),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        /// Divider with "ή"
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[400],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Color(0xFFF5F5F7),
                child: const Text('ή'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        /// SMS Instructions
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(text: 'ΣΤΕΙΛΤΕ '),
              TextSpan(
                text: 'ΡΟ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFED1953),
                ),
              ),
              TextSpan(text: ' (ΚΕΝΟ) '),
              TextSpan(
                text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFED1953),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
