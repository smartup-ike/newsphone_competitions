import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import 'package:newsphone_competitions/data/services/brand_service.dart';

class ContestInstructions extends StatelessWidget {
  final List<String> prefixs;
  final String? messageSuffix;
  final String? callSuffix;

  const ContestInstructions({
    super.key,
    required this.prefixs,
    this.messageSuffix,
    this.callSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final brand = BrandService.current;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Οδηγίες Συμμετοχής:', style: NewsphoneTypography.body15Bold),
        const SizedBox(height: 8),
        Text(
          'ΚΑΛΕΣΕ ΑΠΟ ΣΤΑΘΕΡΟ Ή ΚΙΝΗΤΟ ΣΤΟ',
          style: NewsphoneTypography.body15Medium,
        ),
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Medium,
            children: [
              TextSpan(
                text: '${brand.callNumber} ',
                style: TextStyle(
                  color: NewsphoneTheme.emphasis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: 'ΑΦΗΣΕ '),
              TextSpan(
                text: callSuffix ?? 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ',
                style: TextStyle(
                  color: NewsphoneTheme.emphasis,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        /// Divider with "ή"
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: NewsphoneTheme.dividerMuted,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: NewsphoneTheme.surfaceMuted,
                child: const Text('ή'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        /// SMS Instructions
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Medium,
            children: [
              const TextSpan(text: 'ΣΤΕΙΛΕ '),
              TextSpan(
                text: prefixs.join(' ή '),
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.emphasis,
                ),
              ),
              const TextSpan(text: ' (ΚΕΝΟ) '),
              TextSpan(
                text: messageSuffix ?? 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.emphasis,
                ),
              ),
              // Only when SMS goes to another number than calls; otherwise
              // the text stays exactly as before.
              if (brand.smsNumber != brand.callNumber) ...[
                const TextSpan(text: ' ΣΤΟ '),
                TextSpan(
                  text: brand.smsNumber,
                  style: NewsphoneTypography.body15Bold.copyWith(
                    color: NewsphoneTheme.emphasis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
