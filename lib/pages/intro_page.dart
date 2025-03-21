import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_button.dart';

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
            const Image(image: AssetImage('assets/newphone_logo_150.png')),
            const SizedBox(height: 25),
            Text(
              'Καλώς ήρθατε στη Newsphone Hellas',
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
