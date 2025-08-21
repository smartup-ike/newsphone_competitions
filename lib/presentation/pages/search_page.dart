import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/list_competition.dart';
import '../../data/provider/comp_provider.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/extractArguments';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searched = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<CompetitionsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          (provider.getSearchedList(searched).isNotEmpty)
              ? ListCompetition(
                competitions: provider.getSearchedList(searched),
              )
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.wallet_giftcard_sharp,
                      size: 60,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Δε βρέθηκαν διαγωνισμοί!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
