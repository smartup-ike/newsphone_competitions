import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_dialog.dart';
import 'package:newsphone_competitions/models/competition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/date_time_format.dart';
import '../functions/helper_functions.dart';
import '../provider/comp_provider.dart';

class InfoPage extends StatelessWidget {
  static const routeName = '/extractArguments';

  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final competition =
        ModalRoute.of(context)!.settings.arguments as Competition;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          competition.prizeName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - (40),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: Image.asset(competition.imgPath).image,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        competition.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        // Further control if needed
                        child: Text(
                          '${DateTime.now().isBefore(competition.endDate) ? 'ΚΛΗΡΩΣΗ' : 'ΚΛΗΡΩΘΗΚΕ'}: ${formatDate(competition.endDate)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Οδηγίες Συμμετοχής : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          children: [
                            const TextSpan(
                              text: 'ΚΑΛΕΣΤΕ ΑΠΟ ΣΤΑΘΕΡΟ Ή ΚΙΝΗΤΟ \nΣΤΟ ',
                            ),
                            TextSpan(
                              text: '${competition.phone}\n',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                            const TextSpan(text: 'ΑΦΗΣΤΕ '),
                            const TextSpan(
                              text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: 'Ή ΣΤΕΙΛΤΕ '),
                            TextSpan(
                              text: '${competition.msgInit} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: '(ΚΕΝΟ) '),
                            const TextSpan(
                              text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: 'ΣΤΟ '),
                            TextSpan(
                              text: competition.phone,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                            const TextSpan(text: '\n\nΣταθερό '),
                            TextSpan(
                              text: '3,14€',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: '/ΚΛΗΣΗ με ΦΠΑ\nΚινητό '),
                            TextSpan(
                              text: '3,29€',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: '/ΚΛΗΣΗ - SMS με ΦΠΑ'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          children: [
                            const TextSpan(
                              text: '• Δωροεπιταγή για όλους από το  ',
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () => launchURL('https://winnow.gr'),
                                child: Text(
                                  'winnow.gr',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (DateTime.now().isBefore(competition.endDate))
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyDialog(
                                    phoneNumber: competition.phone,
                                    message: competition.msgInit,
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Δήλωσε Συμμετοχή',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      const SizedBox(height: 7),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          children: [
                            const TextSpan(text: 'Οροι: '),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap:
                                    () => launchURL('https://www.antenna.gr'),
                                child: const Text(
                                  'www.antenna.gr',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    // Makes it look like a link
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(
                              text: ' | Γρ. Εξυπ. 2109472116 Newsphone Hellas',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
