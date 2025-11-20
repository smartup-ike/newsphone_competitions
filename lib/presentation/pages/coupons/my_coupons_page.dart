import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/coupons_page.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'package:newsphone_competitions/presentation/pages/settings/settings_page.dart';

import '../../../core/themes/newsphone_theme.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/auth/auth_cubit.dart';
import '../../../logic/blocs/coupons/cupons_cubit.dart';
import 'coupons_initialize.dart';

class MyCouponsPage extends StatelessWidget {
  const MyCouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F7),
        body: BlocBuilder<CouponsCubit, CouponsState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              print('asdffff');
              return Center(child: Text(state.error!));
            }

            if (state.user == null) {
              return Center(child: Text("Κατι πηγε στραβα!!"));
            }

            final count = state.user!.couponBalance;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  floating: false,
                  pinned: true,
                  centerTitle: true,
                  title: Text(
                    'Οι δωρεάν συμμετοχές μου',
                    style: NewsphoneTypography.body17SemiBold,
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1.0),
                    child: Container(color: Colors.grey[300], height: 1.0),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        // 1. Sign out from Firebase
                        await context.read<AuthCubit>().signOut();
                        context.read<CouponsCubit>().reset();

                        // 3. Navigate to the initial page and clear navigation stack
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomePage()),
                              (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Διαθέσιμες Συμμετοχές',
                          style: NewsphoneTypography.heading6Bold.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Εδώ μπορείτε να δείτε όλες τις συμμετοχές που έχετε κερδίσει ή αποκτήσει, την κατάστασή τους (Ενεργή/Χρησιμοποιημένη) και τους διαγωνισμούς στους οποίους μπορείτε να τις χρησιμοποιήσετε.',
                          style: NewsphoneTypography.body13Regular.copyWith(
                            color: NewsphoneTheme.neutral40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        // 1. Define the LinearGradient
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE082FF), Color(0xFF0765CB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Διαθέσιμες δωρεάν συμμετοχές',
                              style: NewsphoneTypography.body12Regular.copyWith(
                                color: NewsphoneTheme.neutralWhite,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'x${count}',
                              style: NewsphoneTypography.heading4SemiBold
                                  .copyWith(color: NewsphoneTheme.neutralWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...state.transactions.map(
                          (tx) => Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: NewsphoneTheme.neutralWhite,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Εξαργυρώθηκε',
                                              style: NewsphoneTypography
                                                  .body12Regular
                                                  .copyWith(
                                                    color:
                                                        NewsphoneTheme
                                                            .neutral40,
                                                  ),
                                            ),
                                            Text(
                                              'x${tx.couponsSpent}',
                                              style:
                                                  NewsphoneTypography
                                                      .body16SemiBold,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Ημερομηνία εξαργύρωσης',
                                              style: NewsphoneTypography
                                                  .body12Regular
                                                  .copyWith(
                                                    color:
                                                        NewsphoneTheme
                                                            .neutral40,
                                                  ),
                                            ),
                                            Text(
                                              DateFormat(
                                                'dd/MM/yyyy',
                                              ).format(tx.transactionDate),
                                              style:
                                                  NewsphoneTypography
                                                      .body16SemiBold,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Διαγωνισμός',
                                      style: NewsphoneTypography.body12Regular
                                          .copyWith(
                                            color: NewsphoneTheme.neutral40,
                                          ),
                                    ),
                                    Text(
                                      context
                                              .read<CouponsCubit>()
                                              .getContestName(
                                                tx.contestId.toString(),
                                              ) ??
                                          '—',
                                      style: NewsphoneTypography.body16SemiBold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
