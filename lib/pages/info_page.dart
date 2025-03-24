import 'package:flutter/material.dart';
import 'package:newsphone_competitions/models/competition.dart';
import 'package:newsphone_competitions/components/info_widget.dart';

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
              InfoWidget(competition: competition),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
