import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/blocs/contest/contests_cubit.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import '../contest_content/contest_content_page.dart';
import 'components/category_button.dart';
import 'components/contest_card.dart';

class ContestsPage extends StatelessWidget {
  const ContestsPage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<NotificationCubit>().loadNotifications();
    await context.read<ContestsCubit>().fetchContests();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'ΟΛΑ',
      'Μεγάλοι διαγωνισμοί',
      'Οχήματα',
      'Κινητά',
      'Ταξίδια',
      'Χρήματα',
      'Ψώνια',
    ];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(
          slivers: [
            // 🔹 Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    context.read<ContestsCubit>().searchContests(query);
                  },
                  onSubmitted: (query) {
                    context.read<ContestsCubit>().searchContests(query);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Αναζήτηση',
                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFE7E9EB),
                  ),
                ),
              ),
            ),

            // 🔹 Intro Text
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: Text(
                  'Δείτε όλους τους διαγωνισμούς που τρέχουν τώρα και δηλώστε συμμετοχή!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 🔹 Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: BlocBuilder<ContestsCubit, ContestsState>(
                    builder: (context, state) {
                      String selectedCategory = 'ΟΛΑ';
                      if (state is ContestsLoaded) {
                        selectedCategory = state.selectedCategory;
                      }

                      // Get font size from theme (labelLarge or bodyMedium)
                      final textTheme = Theme.of(context).textTheme;
                      final baseFontSize = textTheme.labelLarge?.fontSize ?? 16;

                      // Calculate height: font size * multiplier + some padding
                      final dynamicHeight =
                          baseFontSize *
                          MediaQuery.of(context).textScaleFactor *
                          3.2;

                      return SizedBox(
                        height: dynamicHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (
                              int index = 0;
                              index < categories.length;
                              index++
                            )
                              CategoryButton(
                                category: categories[index],
                                isSelected:
                                    categories[index] == selectedCategory,
                                isFirst: index == 0,
                                isLast: index == categories.length - 1,
                                onTap: () {
                                  context.read<ContestsCubit>().filterContests(
                                    categories[index],
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // 🔹 Contest Grid
            BlocBuilder<ContestsCubit, ContestsState>(
              builder: (context, state) {
                if (state is ContestsLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is ContestsError) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Κάτι πήγε στραβά',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is ContestsLoaded) {
                  if (state.contests.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.search_off_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Δεν βρέθηκε διαγωνισμός!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final contest = state.contests[index];
                        return ContestCard(
                          contest: contest,
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
                      }, childCount: state.contests.length),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
