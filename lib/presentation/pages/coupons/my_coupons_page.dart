import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/newsphone_theme.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/coupons/cupons_cubit.dart';

class MyCouponsPage extends StatelessWidget {
  const MyCouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
        body: BlocBuilder<CouponsCubit, CouponsState>(
            builder: (context, state) {
              if (state.loading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state.error != null) {
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
                      'Τα Κουπόνια μου',
                      style: NewsphoneTypography.body17SemiBold,
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1.0),
                      child: Container(color: Colors.grey[300], height: 1.0),
                    ),
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
                            'Διαθέσιμα Κουπόνια',
                            style: NewsphoneTypography.heading6Bold.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Εδώ μπορείτε να δείτε όλα τα κουπόνια που έχετε κερδίσει ή αποκτήσει, την κατάστασή τους (Ενεργό/Χρησιμοποιημένο) και τους διαγωνισμούς στους οποίους μπορείτε να τα χρησιμοποιήσετε.',
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
                                'Διαθέσιμα κουπόνια',
                                style: NewsphoneTypography.body12Regular.copyWith(
                                  color: NewsphoneTheme.neutralWhite,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'x${count}',
                                style: NewsphoneTypography.heading4SemiBold.copyWith(
                                  color: NewsphoneTheme.neutralWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
    );
  }
}
