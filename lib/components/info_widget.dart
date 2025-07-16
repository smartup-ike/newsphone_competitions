import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newsphone_competitions/models/competition.dart';
import 'package:newsphone_competitions/pages/terms_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_dialog.dart';
import '../functions/date_time_format.dart';
import '../functions/helper_functions.dart';

class InfoWidget extends StatelessWidget {
  final Competition competition;

  const InfoWidget({super.key, required this.competition});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    competition.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${DateTime.now().isBefore(competition.endDate) ? 'ΚΛΗΡΩΣΗ' : 'ΚΛΗΡΩΘΗΚΕ'}: ${formatDate(competition.endDate)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
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
                  const TextSpan(text: 'ΚΑΛΕΣΤΕ ΑΠΟ ΣΤΑΘΕΡΟ Ή ΚΙΝΗΤΟ \nΣΤΟ '),
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
                  const TextSpan(text: '• Δωροεπιταγή για όλους από το  '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () => launchURL('https://winnow.gr'),
                      child: Text(
                        'winnow.gr',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                children: [
                  const TextSpan(text: 'Όροι Χρήσης: '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TermsPage()),
                        );
                      },
                      child: const Text(
                        'Πάτησε Εδώ',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          // Makes it look like a link
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: ' | Γρ. Εξυπ. '),
                  TextSpan(
                    text: '2109472116',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () async {
                            final Uri telUri = Uri(
                              scheme: 'tel',
                              path: '2109472116',
                            );
                            if (await canLaunchUrl(telUri)) {
                              await launchUrl(telUri);
                            } else {
                              // optionally handle error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Αδύνατη η κλήση στον αριθμό.'),
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
