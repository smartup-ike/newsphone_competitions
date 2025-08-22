import 'package:flutter/material.dart';

import '../../../core/constans/terms.dart';

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
      backgroundColor: const Color(0xffF2F4F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            floating: false,
            pinned: true,
            centerTitle: true,
            title: Text(
              isGreek ? 'Όροι χρήσης' : 'Terms of Use',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF121212),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.language, color: Colors.black),
                tooltip: 'Switch language',
                onPressed: () {
                  setState(() {
                    isGreek = !isGreek;
                  });
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0), // Height of the divider
              child: Container(
                color: Colors.grey[300], // Color of the divider
                height: 1.0, // Thickness of the divider
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0), // Padding for the content
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                isGreek
                    ? [for (var term in greekTerms) term]
                    : [for (var term in englishTerms) term],
              ),
            ),
          ),
        ],
      ),
    );
  }
}