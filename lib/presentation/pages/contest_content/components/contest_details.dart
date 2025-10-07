import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsphone_competitions/core/functions/date_time_format.dart';

import '../../../widgets/button_gradient.dart';
import '../../../../data/models/contests.dart';
import 'contest_instrunctions.dart';
import 'contest_prices.dart';
import 'contest_terms.dart';

class ContestDetails extends StatelessWidget {
  final VoidCallback buttonClick;
  final VoidCallback onPressTermsButton;
  final VoidCallback onPressWinnow;
  final VoidCallback onPressCallService;

  final Contest contest;

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
              // 🔹 Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${isContestEnded ? 'ΚΛΗΡΩΘΗΚΕ' : 'ΚΛΗΡΩΣΗ'} ${formatDate(contest.dateEnd)}',
                    style: GoogleFonts.robotoFlex(
                      color:
                          isContestEnded
                              ? Color(0xFFFF0000)
                              : Color(0xFF00A113),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/Vector.svg',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          contest.shows.map((show) => show.name).join(', '),
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF054279),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 🔹 Title
              Text(
                contest.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 Instructions
              ContestInstructions(
                prefixs: contest.shows.map((show) => show.prefix).toList(),
              ),

              const SizedBox(height: 40),

              // 🔹 Prices
              const ContestPrices(),

              const SizedBox(height: 16),

              // 🔹 Button
              if (!isContestEnded) ...[
                ButtonGradient(
                  title: 'Δήλωσε Συμμετοχή',
                  colors: const [Color(0xFF08C7F4), Color(0xFF0765CB)],
                  onPressed: buttonClick,
                ),
              ],

              const SizedBox(height: 16),

              // 🔹 Terms & Contact
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
