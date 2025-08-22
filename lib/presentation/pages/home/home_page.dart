import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/settings_page.dart';

import '../../../data/models/contests.dart';
import '../../../logic/blocs/contest/contests_cubit.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../contest_content/contest_content_page.dart';
import 'components/category_button.dart';
import 'components/contest_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'ΌΛΑ';
  List<Content> filteredContests = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentContestsState = context.read<ContestsCubit>().state;

    if (currentContestsState is ContestsLoaded) {
      selectedCategory = 'ΌΛΑ';
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// 🔹 App Bar (sticky)
            HomePageAppBar(
              clickDrawerFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              clickNotificationFunction: () {},
            ),

            /// 🔹 Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Αναζήτηση',
                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFE7E9EB),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            /// 🔹 Intro Text
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: Text(
                  'Δείτε όλους τους διαγωνισμούς που τρέχουν τώρα και δηλώστε συμμετοχή!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            /// 🔹 Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      height: 40,
                      child: BlocBuilder<ContestsCubit, ContestsState>(
                        builder: (context, state) {
                          String selectedCategory = 'ΌΛΑ';
                          if (state is ContestsLoaded) {
                            selectedCategory = state.selectedCategory;
                          }

                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...[
                                'ΌΛΑ',
                                'Οχήματα',
                                'Κινητά',
                                'Ταξίδια',
                                'Χρήματα',
                                'Ψώνια',
                              ].map(
                                (category) => CategoryButton(
                                  category: category,
                                  isSelected: category == selectedCategory,
                                  onTap: () {
                                    context
                                        .read<ContestsCubit>()
                                        .filterContests(category);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// 🔹 Contest Grid: Now Fetches from Cubit
            BlocBuilder<ContestsCubit, ContestsState>(
              builder: (context, state) {
                if (state is ContestsLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is ContestsError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is ContestsLoaded) {
                  final contests = state.contests;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final contest = contests[index];
                        return ContestCard(
                          content: contest,
                          clickContentFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ContestContentPage(contest: contest),
                              ),
                            );
                          },
                        );
                      }, childCount: contests.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.45,
                          ),
                    ),
                  );
                }
                // Handle initial state or unexpected state
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),

      /// 🔹 Bottom Nav Bar
      bottomNavigationBar: HomePageBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
