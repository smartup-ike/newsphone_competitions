import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_competition_tile.dart';
import 'package:newsphone_competitions/components/my_drawer.dart';
import 'package:newsphone_competitions/provider/comp_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'ΔΙΑΓΩΝΙΣΜΟΙ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MyDrawer(),
      drawerDragStartBehavior: DragStartBehavior.down,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Δες όλους τους διαγωνισμούς παρακάτω!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 550,
            child:
                provider.filteredItems.isNotEmpty
                    ? ListView.builder(
                      itemCount: provider.filteredItems.length,
                      padding: const EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MyCompetitionTile(
                          competition: provider.filteredItems[index],
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/info_page',
                                arguments: provider.filteredItems[index],
                              ),
                        );
                      },
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
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Center(
              child: Text(
                'N e w s p h o n e ●󠁯 H e ll a s',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
