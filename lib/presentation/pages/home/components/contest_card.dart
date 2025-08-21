import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/button_gradient.dart';
import '../../../../data/models/contests.dart';

/// 🔹 Contest Card (unchanged)
class ContestCard extends StatelessWidget {
  final Content content;
  final VoidCallback clickContentFunction;

  const ContestCard({super.key, required this.content, required this.clickContentFunction});

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isContestEnded = content.dateEnd.isBefore(DateTime.now());

    return InkWell(
      onTap: clickContentFunction,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${isContestEnded ? 'ΚΛΗΡΩΘΗΚΕ' : 'ΚΛΗΡΩΣΗ'} ${formatDate(content.dateEnd)}',
              style: GoogleFonts.robotoFlex(
                color:
                    isContestEnded
                        ? const Color(0xFFFF0000)
                        : const Color(0xFF00A113),
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
            AspectRatio(aspectRatio: 1, child: Image.asset(content.imageUrl!)),
            Text(
              'ΚΕΡΔΙΣΤΕ ΤΟ ${content.name.toUpperCase()}',
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Συμμετοχή στον διαγωνισμό για μια μοναδική ευκαιρία να κερδίσεις το νέο...',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.robotoFlex(
                color: Colors.grey[600],
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 25),
            ButtonGradient(
              title: "Δήλωσε Συμμετοχή",
              colors: const [Color(0xFF08C7F4), Color(0xFF0765CB)],
              isDisabled: isContestEnded,
              onPressed: clickContentFunction,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
