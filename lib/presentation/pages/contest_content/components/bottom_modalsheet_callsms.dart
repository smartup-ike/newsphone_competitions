import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

import '../../../../logic/blocs/coupons/cupons_cubit.dart';

void showContestCouponsBottomSheet(
  BuildContext context,
  String cuponsNumber,
  int balance,
  VoidCallback onIncreaseButton,
  VoidCallback onDecreaseButton,
  VoidCallback onPressButton,
) {
  int currentValue = int.parse(cuponsNumber);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: NewsphoneTheme.surfaceMuted,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    height: 5.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: NewsphoneTheme.divider,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Title
                  Text(
                    'Διαλέξτε πόσες συμμετοχές θέλετε να χρησιμοποιήσετε τώρα για τον διαγωνισμό',
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.heading6Bold,
                  ),
                  const SizedBox(height: 8.0),
                  // Subtitle
                  Text(
                    'Κάθε δωρεάν συμμετοχή που χρησιμοποιείτε σε αυτόν τον διαγωνισμό, σας χαρίζει μία επιπλέον συμμετοχή στην κλήρωση!',
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.body13SemiBold.copyWith(
                      color: NewsphoneTheme.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  // Buttons
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // 1. Define the LinearGradient
                      color: Colors.transparent,
                      border: Border.all(
                        color: NewsphoneTheme.outlineMuted, // Custom color
                        width: 1.0, // Custom width (2 pixels)
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Επιλέξτε δωρεάν συμμετοχές',
                            style: NewsphoneTypography.body13Medium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "$currentValue",
                            style: NewsphoneTypography.heading5SemiBold,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:
                            currentValue > 1
                                ? () {
                                  onDecreaseButton();
                                  setState(() {
                                    currentValue--;
                                  });
                                }
                                : null,
                        child: Opacity(
                          opacity: currentValue > 1 ? 1.0 : 0.5,
                          child: Container(
                            height: 56,
                            width: 85,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [NewsphoneTheme.gradientStart, NewsphoneTheme.gradientEnd],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.minus,
                                color: NewsphoneTheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          onIncreaseButton();
                          setState(() {
                            if (currentValue < balance) currentValue++;
                          });
                        },
                        child: Container(
                          height: 56,
                          width: 85,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [NewsphoneTheme.gradientStart, NewsphoneTheme.gradientEnd],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.add,
                              color: NewsphoneTheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50.0),
                  BlocConsumer<CouponsCubit, CouponsState>(
                    listener: (context, state) {
                      if (state.spendSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Η συμμετοχή καταχωρήθηκε'),
                          ),
                        );
                      }

                      if (state.error != null && !state.spendSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Κάτι πήγε στραβά')),
                        );
                      }
                    },
                    builder: (context, state) {
                      final loading = state.spendLoading;

                      return InkWell(
                        onTap: loading ? null : onPressButton,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [NewsphoneTheme.gradientStart, NewsphoneTheme.gradientEnd],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child:
                                loading
                                    ? SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: NewsphoneTheme.onPrimary,
                                      ),
                                    )
                                    : Text(
                                      'Επιβεβαίωση Δωρεάν Συμμετοχών',
                                      style: NewsphoneTypography.body13Bold
                                          .copyWith(color: NewsphoneTheme.onPrimary),
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
