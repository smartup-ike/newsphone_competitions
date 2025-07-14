import 'package:flutter/material.dart';

import '../constans/terms.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool isGreek = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          isGreek ? 'Οροι χρήσης' : 'Terms of Use',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Switch language',
            onPressed: () {
              setState(() {
                isGreek = !isGreek;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isGreek
                ? [for (var term in greekTerms) term]
                : [for (var term in englishTerms) term],
          ),
        ),
      ),
    );
  }
}
