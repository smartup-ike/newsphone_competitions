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
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      height: 42,
                      child: BlocBuilder<ContestsCubit, ContestsState>(
                        builder: (context, state) {
                          String selectedCategory = 'ΟΛΑ';
                          if (state is ContestsLoaded) {
                            selectedCategory = state.selectedCategory;
                          }
                          return ListView(
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
                                    context
                                        .read<ContestsCubit>()
                                        .filterContests(categories[index]);
                                  },
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
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is ContestsLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final contest = state.contests[index];
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
