import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data/models/deals.dart';

class DealCard extends StatelessWidget {
  final VoidCallback onPressButton;
  final Deal deal;

  const DealCard({super.key, required this.deal, required this.onPressButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: NewsphoneTheme.neutral95,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            if (deal.companyImage != null)
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: deal.companyImage!,
                width: double.infinity,
                height: 70,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 20),
            Text(deal.name, style: NewsphoneTypography.heading7Bold),
            if (deal.details != null) ...[
              const SizedBox(height: 8),
              Text(
                deal.details!,
                style: NewsphoneTypography.body15Medium.copyWith(
                  color: NewsphoneTheme.neutral40,
                ),
              ),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPressButton,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  backgroundColor: null,
                ).copyWith(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  shadowColor: WidgetStateProperty.all(
                    NewsphoneTheme.neutral95,
                  ),
                ),
                label: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        NewsphoneTheme.primary,
                        NewsphoneTheme.deactivate,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/Lightning.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Πάρε την προσφορά!",
                          style: NewsphoneTypography.body16SemiBold.copyWith(
                            color: NewsphoneTheme.neutralWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
