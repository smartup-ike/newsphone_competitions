import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'ΔΙΑΓΩΝΙΣΜΟΙ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
