import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';

import '../../../../core/themes/newsphone_typography.dart';

class ContestPrices extends StatelessWidget {
  final String? priceLandline;
  final String? priceMobile;

  const ContestPrices({
    super.key,
    this.priceLandline,
    this.priceMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Regular,
            children: [
              const TextSpan(text: 'Σταθερό '),
              TextSpan(
                text: priceLandline != null ?'$priceLandline €' : '',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
              const TextSpan(text: ' / ΚΛΗΣΗ με ΦΠΑ'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: NewsphoneTypography.body15Regular,
            children: [
              const TextSpan(text: 'Κινητό '),
              TextSpan(
                text: priceMobile != null ?'$priceMobile €' : '',
                style: NewsphoneTypography.body15Bold.copyWith(
                  color: NewsphoneTheme.deactivate,
                ),
              ),
              const TextSpan(text: ' / ΚΛΗΣΗ - SMS με ΦΠΑ'),
            ],
          ),
        ),
      ],
    );
  }
}
