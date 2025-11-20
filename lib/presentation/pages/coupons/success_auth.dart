import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/coupons/sing_in_page.dart';

import '../../../core/themes/newsphone_theme.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/coupons/cupons_cubit.dart';

class SuccessAuth extends StatelessWidget {
  const SuccessAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F7),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        // 1. Define the LinearGradient
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE082FF), Color(0xFF0765CB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.circle,
                            color: Colors.white,
                            size: 70,
                          ),
                          Icon(
                            Icons.check_rounded,
                            weight: 100,
                            color: Colors.white,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Επιτυχής Απόδοση Συμμετοχών',
                      textAlign: TextAlign.center,
                      style: NewsphoneTypography.heading3Bold.copyWith(
                        color: NewsphoneTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Μόλις Κερδίσατε!',
                      style: NewsphoneTypography.heading6Bold,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      'Συγχαρητήρια, η διαδικασία ολοκληρώθηκε! Οι 10 δωρεάν συμμετοχές σας για τους διαγωνισμούς μας, πιστώθηκαν επιτυχώς στον λογαριασμό σας. Είστε πλέον στο παιχνίδι με 10 έξτρα ευκαιρίες για τη νίκη!',
                      style: NewsphoneTypography.body13Regular,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // 1. Define the LinearGradient
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFECFEFF),
                            Color(0xFFEFF6FF),
                            Color(0xFFECFEFF),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Οδηγίες Χρήσης',
                              style: NewsphoneTypography.body16SemiBold,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    // 1. Define the LinearGradient
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF08C7F4),
                                        Color(0xFF0765CB),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Επισκεφθείτε την ενότητα "Διαγωνισμοί".',
                                    style: NewsphoneTypography.body15Regular,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    // 1. Define the LinearGradient
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF08C7F4),
                                        Color(0xFF0765CB),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Επιλέξτε σε ποιους διαγωνισμούς θέλετε να χρησιμοποιήσετε τις συμμετοχές σας.',
                                    style: NewsphoneTypography.body15Regular,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    // 1. Define the LinearGradient
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF08C7F4),
                                        Color(0xFF0765CB),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Κατά την ολοκλήρωση των διαδικασιών, θα εμφανιστεί η επιλογή χρήσης των διαθέσιμων συμμετοχών.',
                                    style: NewsphoneTypography.body15Regular,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<CouponsCubit>().init();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: NewsphoneTheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Δείτε τους Διαγωνισμούς",
                        textAlign: TextAlign.center,
                        style: NewsphoneTypography.body17SemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
