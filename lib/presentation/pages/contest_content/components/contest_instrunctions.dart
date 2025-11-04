import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

class ContestInstructions extends StatelessWidget {
  final List<String> prefixs;

  const ContestInstructions({super.key, required this.prefixs});

  @override
  Widget build(BuildContext context) {
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
                text: '14614 ',
                style: TextStyle(
                  color: NewsphoneTheme.deactivate,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: 'ΑΦΗΣΕ '),
              TextSpan(
                text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ - ΤΗΛΕΦΩΝΟ',
                style: TextStyle(
                  color: NewsphoneTheme.deactivate,
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
                color: NewsphoneTheme.neutral60,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: NewsphoneTheme.neutral95,
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
              TextSpan(text: 'ΣΤΕΙΛΕ '),
              TextSpan(
                text: prefixs.join(' ή '),
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
              TextSpan(text: ' (ΚΕΝΟ) '),
              TextSpan(
                text: 'ΟΝΟΜΑΤΕΠΩΝΥΜΟ',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
