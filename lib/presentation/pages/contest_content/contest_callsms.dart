import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/data/models/contests.dart';

import '../../../core/functions/helper_functions.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../../logic/blocs/coupons/cupons_cubit.dart';
import 'components/bottom_modalsheet_callsms.dart';
import 'components/bottom_modalsheet_choosepro.dart';
import 'components/program_button.dart';

class ContestCallsms extends StatefulWidget {
  final String name;
  final String prefix;

  const ContestCallsms({super.key, required this.prefix, required this.name});

  @override
  State<ContestCallsms> createState() => _ContestCallsmsState();
}

class _ContestCallsmsState extends State<ContestCallsms> {
  int selectedIndex = -1;
  int usedCoupons = 1; // default selected for usage

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponsCubit, CouponsState>(
      builder: (context, state) {
        var balance = 0;
        if(state.user != null){
          balance = state.user?.couponBalance ?? 0;
        }


        return Scaffold(
          backgroundColor: NewsphoneTheme.neutralWhite,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                floating: false,
                pinned: true,
                centerTitle: true,
                title: Text(
                  'Τρόπος Συμμετοχής',
                  style: NewsphoneTypography.body17SemiBold,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(color: Colors.grey[300], height: 1.0),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    // Title
                    Text(
                      'Διάλεξε τον τρόπο συμμετοχής',
                      style: NewsphoneTypography.heading6Bold,
                    ),
                    const SizedBox(height: 8.0),
                    // Subtitle
                    Text(
                      'Επίλεξε τρόπο συμμετοχής στον διαγωνισμό.\nΚάλεσε μας ή στείλε μήνυμα.',
                      textAlign: TextAlign.center,
                      style: NewsphoneTypography.body13SemiBold.copyWith(
                        color: NewsphoneTheme.neutral40,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOptionButton(
                          icon: 'assets/images/icons/PhoneCall.svg',
                          label: 'Κάλεσε',
                          firstColor: NewsphoneTheme.primary,
                          secColor: NewsphoneTheme.primary,
                          onTap: () => handleCall(widget.name),
                        ),
                        _buildOptionButton(
                          icon: 'assets/images/icons/ChatCircleDots.svg',
                          label: 'Στείλε SMS',
                          firstColor: NewsphoneTheme.primary,
                          secColor: NewsphoneTheme.primary,
                          onTap: () => handleSms(widget.prefix, widget.name),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child:
                    balance > 0
                        ? Row(
                          children: [
                            _buildOptionButton(
                              icon: 'assets/images/icons/Coupon.svg',
                              label: 'Χρήση Κουπονιού',
                              firstColor: Color(0XFFE082FF),
                              secColor: NewsphoneTheme.primary,
                              onTap: () {
                                showContestCouponsBottomSheet(
                                  context,
                                  usedCoupons.toString(),
                                  balance,
                                  () {
                                    // Increase coupon selection
                                    if (usedCoupons < balance) {
                                      setState(() => usedCoupons++);
                                    }
                                  },
                                  () {
                                    // Decrease coupon selection
                                    if (usedCoupons > 1) {
                                      setState(() => usedCoupons--);
                                    }
                                  },
                                  () {
                                    // Confirm coupon usage
                                    print("Use $usedCoupons coupons");
                                  },
                                );
                              },
                            ),
                          ],
                        )
                        : const SizedBox(), // Hide button if no coupons
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildOptionButton({
  required String icon,
  required String label,
  required Color firstColor,
  required Color secColor,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [firstColor, secColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SvgPicture.asset(
              icon,
              height: 30.0,
              width: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          const SizedBox(height: 50.0),
        ],
      ),
    ),
  );
}
