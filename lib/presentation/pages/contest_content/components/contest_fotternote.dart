import 'package:flutter/material.dart';

class ContestFooterNote extends StatelessWidget {
  const ContestFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          '*Δωροεπιταγή για όλους από το ',
          style: TextStyle(fontSize: 11),
        ),
        Text(
          'winnow.gr',
          style: TextStyle(fontSize: 11, color: Colors.blue),
        ),
      ],
    );
  }
}
