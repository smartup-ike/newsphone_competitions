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
  final Content contest;

  const ContestDetails({
    super.key,
    required this.contest,
    required this.buttonClick,
  });

  @override
  Widget build(BuildContext context) {
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
                'ΚΛΗΡΩΣΗ ${contest.dateEnd.day}/${contest.dateEnd.month}/${contest.dateEnd.year}',
                style: GoogleFonts.robotoFlex(
                  color: const Color(0xFF00A113),
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

              const SizedBox(height: 8),

              /// 🔹 Footer note
              const ContestFooterNote(),

              const SizedBox(height: 16),

              /// 🔹 Button
              ButtonGradient(
                title: 'Δήλωσε Συμμετοχή',
                colors: const [Color(0xFF08C7F4), Color(0xFF0765CB)],
                onPressed: buttonClick,
              ),
              const SizedBox(height: 16),

              /// 🔹 Terms & Contact
              const ContestTerms(),
            ],
          ),
        ),
      ),
    );
  }
}
