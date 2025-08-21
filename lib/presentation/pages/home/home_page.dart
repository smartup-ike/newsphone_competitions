import 'package:flutter/material.dart';


import '../../../data/models/contests.dart';
import '../../../data/services/api_service.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
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
    _filterContests('ΌΛΑ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// 🔹 App Bar (sticky)
            HomePageAppBar(
              clickDrawerFunction: () {},
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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // List of category names
                          ...[
                                'ΌΛΑ',
                                'Οχήματα',
                                'Κινητά',
                                'Ταξίδια',
                                'Χρήματα',
                                'Ψώνια',
                              ]
                              .map(
                                (category) => CategoryButton(
                                  category: category,
                                  isSelected: selectedCategory == category,
                                  onTap: () => _filterContests(category),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// 🔹 Contest Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final contest = filteredContests[index];
                  return ContestCard(
                    content: contest,
                    clickContentFunction: () {
                      print('asdf');
                    },
                  );
                }, childCount: filteredContests.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.45,
                ),
              ),
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

  void _filterContests(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'ΌΛΑ') {
        filteredContests = dummyContests;
      } else {
        filteredContests =
            dummyContests.where((c) => c.contentsType == category).toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
