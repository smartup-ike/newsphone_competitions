import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

import '../../../../core/themes/newsphone_typography.dart';

class ContestPrices extends StatelessWidget {
  const ContestPrices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Regular,
            children: [
              TextSpan(text: 'Σταθερό '),
              TextSpan(
                text: '3,14 €',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
              TextSpan(text: ' / ΚΛΗΣΗ με ΦΠΑ'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Regular,
            children: [
              TextSpan(text: 'Κινητό '),
              TextSpan(
                text: '3,29 €',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
              TextSpan(text: ' / ΚΛΗΣΗ - SMS με ΦΠΑ'),
            ],
          ),
        ),
      ],
    );
  }
}
