import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import '../../../data/services/analytics_service.dart';
import '../../../logic/blocs/categories/categories_cubit.dart';
import '../../../logic/blocs/contest/contests_cubit.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import '../contest_content/contest_content_page.dart';
import 'components/category_button.dart';
import 'components/contest_card.dart';

class ContestsPage extends StatefulWidget {
  const ContestsPage({super.key});

  @override
  State<ContestsPage> createState() => _ContestsPageState();
}

class _ContestsPageState extends State<ContestsPage> {
  String selectedCategory = 'ΟΛΑ';

  Future<void> _onRefresh(BuildContext context) async {
    context.read<NotificationCubit>().loadNotifications();
    await context.read<ContestsCubit>().fetchContests();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RefreshIndicator(
        color: NewsphoneTheme.primary,
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                    hintStyle: NewsphoneTypography.body15Regular.copyWith(
                      color: NewsphoneTheme.neutral30,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: const BorderSide(
                        color: NewsphoneTheme.neutral30,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: const BorderSide(
                        color: NewsphoneTheme.neutral30,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: const BorderSide(
                        color: NewsphoneTheme.neutral30,
                        width: 1.0,
                      ),
                    ),
                    filled: false,
                    fillColor: const Color(0xFFE7E9EB),
                  ),
                ),
              ),
            ),

            // 🔹 Intro Text
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: Text(
                  'Δές όλους τους διαγωνισμούς που τρέχουν τώρα και δήλωσε συμμετοχή!',
                  style: NewsphoneTypography.heading7Bold,
                ),
              ),
            ),

            // 🔹 Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, catState) {
                    // Handle loading
                    if (catState is CategoriesLoading) {
                      return const SizedBox(
                        height: 40,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    // Handle error
                    if (catState is CategoriesError) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Αποτυχία φόρτωσης κατηγοριών",
                          style: NewsphoneTypography.body15Regular,
                        ),
                      );
                    }

                    // Handle loaded categories
                    if (catState is CategoriesLoaded) {
                      final categories =
                          ['ΟΛΑ'] +
                          catState.categories.map((c) => c.name).toList();

                      final textTheme = Theme.of(context).textTheme;
                      final baseFontSize = textTheme.labelLarge?.fontSize ?? 16;
                      final dynamicHeight =
                          baseFontSize *
                          MediaQuery.of(context).textScaleFactor *
                          3.2;

                      return SizedBox(
                        height: dynamicHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryButton(
                              category: categories[index],
                              isSelected: categories[index] == selectedCategory,
                              isFirst: index == 0,
                              isLast: index == categories.length - 1,
                              onTap: () {
                                setState(() {
                                  selectedCategory = categories[index];
                                });
                                context.read<ContestsCubit>().filterContests(
                                  categories[index],
                                );
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox();
                  },
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
                  print(state.message);
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: NewsphoneTheme.neutral30,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Κάτι πήγε στραβά',
                            style: NewsphoneTypography.heading6Bold.copyWith(
                              color: NewsphoneTheme.neutral30,
                            ),
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
                          children: [
                            Icon(
                              Icons.search_off_outlined,
                              size: 60,
                              color: NewsphoneTheme.neutral30,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Δεν βρέθηκε διαγωνισμός!',
                              textAlign: TextAlign.center,
                              style: NewsphoneTypography.heading6Bold.copyWith(
                                color: NewsphoneTheme.neutral30,
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
                            AnalyticsService.logOpenContentDeal(
                              contest.id,
                              contest.name,
                              true,
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
