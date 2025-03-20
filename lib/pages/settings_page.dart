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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Γενικές",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              title: Text("Αγαπημένα"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.favorite),
              onTap: ()=>Navigator.pushNamed(context, '/fav-page'),
            ),

            ListTile(
              title: Text("Ειδοποιήσεις"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.notification_add_sharp),
            ),
            SizedBox(height: 12),
            Text(
              "Απορρήτου",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              title: Text("Όροι χρήσης"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.privacy_tip_rounded),
              onTap: ()=>Navigator.pushNamed(context, '/terms-page'),
            ),
          ],
        ),
      ),
    );
  }
}
