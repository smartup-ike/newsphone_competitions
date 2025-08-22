import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/button_gradient.dart';
import '../../../../data/models/contests.dart';
import 'contest_fotternote.dart';
import 'contest_instrunctions.dart';
import 'contest_prices.dart';
import 'contest_terms.dart';

class ContestDetails extends StatelessWidget {
  final VoidCallback buttonClick;
  final VoidCallback onPressTermsButton;
  final VoidCallback onPressWinnow;
  final VoidCallback onPressCallService;

  final Content contest;

  const ContestDetails({
    super.key,
    required this.contest,
    required this.buttonClick,
    required this.onPressTermsButton,
    required this.onPressWinnow,
    required this.onPressCallService,
  });

  @override
  Widget build(BuildContext context) {
    final isContestEnded = contest.dateEnd.isBefore(DateTime.now());

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Date
              Text(
                '${isContestEnded ? 'ΚΛΗΡΩΘΗΚΕ' : 'ΚΛΗΡΩΣΗ'} ${contest.dateEnd.day}/${contest.dateEnd.month}/${contest.dateEnd.year}',
                style: GoogleFonts.robotoFlex(
                  color: isContestEnded ? Color(0xFFFF0000) : Color(0xFF00A113),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),

              /// 🔹 Title
              Text(
                'ΚΕΡΔΙΣΤΕ ΤΟ\n${contest.name.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              /// 🔹 Instructions
              const ContestInstructions(),

              const SizedBox(height: 40),

              /// 🔹 Prices
              const ContestPrices(),

              /// 🔹 Footer note
              ContestFooterNote(onPressWinnow: onPressWinnow),

              /// 🔹 Button
              if (!isContestEnded) ...[
                ButtonGradient(
                  title: 'Δήλωσε Συμμετοχή',
                  colors: const [Color(0xFF08C7F4), Color(0xFF0765CB)],
                  onPressed: buttonClick,
                ),
              ],

              const SizedBox(height: 16),

              /// 🔹 Terms & Contact
              ContestTerms(
                onPressTermsButton: onPressTermsButton,
                onPressCallService: onPressCallService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
