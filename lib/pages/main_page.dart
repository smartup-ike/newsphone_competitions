import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_competition_tile.dart';
import 'package:newsphone_competitions/components/my_drawer.dart';
import 'package:newsphone_competitions/models/competition.dart';
import 'package:newsphone_competitions/provider/comp_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final comps = context.watch<CompetitionsProvider>().comp;
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
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
            child: ListView.builder(
              itemCount: provider.filteredItems.length,
              padding: const EdgeInsets.all(15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final comp = comps[index];
                return MyCompetitionTile(
                  competition: comp,
                  onTap: () => Navigator.pushNamed(context, '/info_page',arguments: comp),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
