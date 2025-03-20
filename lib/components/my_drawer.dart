import 'package:flutter/material.dart';

import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: const Image(
                image: AssetImage('assets/newphone_logo_150.png'),
              ),
            ),
          ),
          const SizedBox(height: 25),
          MyListTile(
            text: 'Διαγωνισμοί',
            icon: Icons.home,
            onTap: () => Navigator.of(context).pop(),
          ),
          MyListTile(
            text: 'Ρυθμίσεις',
            icon: Icons.settings,
            onTap: () {
              Navigator.of(context).pop();

              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
