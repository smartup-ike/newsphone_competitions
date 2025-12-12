import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

class ContestTerms extends StatelessWidget {
  final VoidCallback onPressTermsButton;

  const ContestTerms({
    super.key,
    required this.onPressTermsButton,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: NewsphoneTypography.body12Regular,
        children: [
          const TextSpan(text: 'Δες τους Όρους Χρήσης '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: onPressTermsButton,
              child: Text(
                'εδώ',
                style: NewsphoneTypography.body12Regular.copyWith(
                  color: NewsphoneTheme.info50,
                ),
              ),
            ),
          ),
          const TextSpan(text: ' | Δωροεπιταγή για όλους από το winnow.gr'),
          const TextSpan(text: ' | Γρ. Εξυπηρέτησης 2109472116'),
        ],
      ),
    );
  }
}
