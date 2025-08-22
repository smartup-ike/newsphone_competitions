import 'package:flutter/material.dart';

class ContestFooterNote extends StatelessWidget {
  final VoidCallback onPressWinnow;
  const ContestFooterNote({super.key, required this.onPressWinnow});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '*Δωροεπιταγή για όλους από το ',
          style: TextStyle(fontSize: 11),
        ),
        MaterialButton(
          minWidth: 0,
          padding: const EdgeInsets.all(0),
          onPressed: onPressWinnow,
          child: const Text(
            'winnow.gr',
            style: TextStyle(fontSize: 11, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}