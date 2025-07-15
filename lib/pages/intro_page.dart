import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_button.dart';
import 'package:newsphone_competitions/components/fav_filters.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/proino_logo.png'),width: 150,  // or any size you want
                height: 150),
            const SizedBox(height: 25),
            Text(
              'Καλώς ήρθατε στο Πρωινό του ANT1',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Ανακαλύψτε τους πιο συναρπαστικούς διαγωνισμούς και κερδίστε απίθανα δώρα!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Διαμορφώστε τα ενδιαφέροντά σας ανά πάσα στιγμή για να λαμβάνετε προτάσεις προσαρμοσμένες σε εσάς.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold
              ),
            ),
            FavFilters(),
            const SizedBox(height: 25),
            MyButton(
              onTap: () => Navigator.popAndPushNamed(context, '/main_page'),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
