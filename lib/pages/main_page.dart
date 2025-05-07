import 'package:flutter/material.dart';
import 'package:newsphone_competitions/components/my_drawer.dart';
import 'package:newsphone_competitions/models/competition.dart';
import 'package:newsphone_competitions/provider/comp_provider.dart';
import 'package:provider/provider.dart';

import '../components/list_competition.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionsProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: NestedScrollView(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SearchBar(
                    elevation: WidgetStatePropertyAll(0),
                    controller: searchController,
                    hintText: 'Αναζήτηση...',
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.inversePrimary, // Text color
                        fontSize: 16, // Font size
                      ),
                    ),
                    trailing: [Icon(Icons.search_sharp)],
                    onSubmitted:
                        (searched) => Navigator.pushNamed(
                          context,
                          '/search_page',
                          arguments: searched,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Δες όλους τους διαγωνισμούς παρακάτω!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (provider.filteredItems.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Δείτε εδώ 🔥',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListCompetition(competitions: provider.filteredItems),
                    ],
                  ),

                for (var type in CompetitionType.values) ...[
                  if (provider.getItemsByType(type).isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            '${greekNames[type.index]}:',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListCompetition(
                          competitions: provider.getItemsByType(type),
                        ),
                      ],
                    ),
                ],
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    'N e w s p h o n e ● H e ll a s',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                ),
              ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
