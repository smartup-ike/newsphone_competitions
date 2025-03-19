import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('ΡΥΘΜΙΣΕΙΣ', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
