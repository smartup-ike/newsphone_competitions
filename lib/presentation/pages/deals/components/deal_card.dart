import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/models/deals.dart';

class DealCard extends StatelessWidget {
  final VoidCallback onPressButton;
  final Deal deal;

  const DealCard({super.key, required this.deal, required this.onPressButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF5F5F7),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (deal.companyImage != null)
              Image.asset(
                deal.companyImage!,
                width: double.infinity,
                height: 82,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 12),
            Text(
              deal.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (deal.details != null) ...[
              const SizedBox(height: 8),
              Text(
                deal.details!,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
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
                  backgroundColor: null, // we'll override with gradient
                ).copyWith(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  shadowColor: WidgetStateProperty.all(Color(0xff555758)),
                ),
                label: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
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
                        const Text(
                          "Πάρε την προσφορά!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
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
