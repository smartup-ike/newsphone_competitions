import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_dialog.dart';
import 'package:newsphone_competitions/models/competition.dart';

import '../models/date_time_format.dart';

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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Colors.grey,
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
                      color: Colors.grey,
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
                          'ΚΛΗΡΩΣΗ: ${formatDate(competition.endDate)}',
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
                          color: Colors.grey,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'ΚΑΛΕΣΤΕ ΑΠΟ ΣΤΑΘΕΡΟ Ή ΚΙΝΗΤΟ \nΣΤΟ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${competition.phone}\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                            const TextSpan(text: 'ΑΦΗΣΤΕ '),
                            const TextSpan(
                              text: ' ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: 'Ή ΣΤΕΙΛΤΕ '),
                            TextSpan(
                              text: '${competition.msgInit} ',
                              style: TextStyle(
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
                              text: '${competition.phone}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Σταθερό ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '3,14€',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(text: '/ΚΛΗΣΗ με ΦΠΑ\n'),
                            TextSpan(text: 'Κινητό '),
                            TextSpan(
                              text: '3,29€',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(text: '/ΚΛΗΣΗ - SMS με ΦΠΑ'),
                          ],
                        ),
                      ),
                      Text(
                        '• Δωροεπιταγή για όλους από το winnow.gr',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
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
                      Text(
                        'Οροι: www.antenna.gr | Γρ. Εξυπ. 2109472116 Newsphone Hellas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
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
