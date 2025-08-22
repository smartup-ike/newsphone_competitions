import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showContestBottomSheet(
  BuildContext context,
  VoidCallback onPressDial,
  VoidCallback onPressMessage,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F7), // Match the card background color
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              height: 5.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            const SizedBox(height: 16.0),
            // Title
            const Text(
              'Διαλέξτε τον τρόπο συμμετοχής',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            // Subtitle
            const Text(
              'Επιλέξτε τρόπο συμμετοχής στον διαγωνισμό.\nΚαλέστε μας ή στείλτε μήνυμα.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24.0),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOptionButton(
                  icon: 'assets/images/icons/PhoneCall.svg',
                  label: 'Καλέστε',
                  details:
                      'Σταθερό 3,14 € / ΚΛΗΣΗ με ΦΠΑ\nΚινητό 3,29 € / ΚΛΗΣΗ με ΦΠΑ',
                  onTap: onPressDial,
                ),
                _buildOptionButton(
                  icon: 'assets/images/icons/ChatCircleDots.svg',
                  label: 'Στείλτε SMS',
                  details: 'SMS 3,29 € / SMS με ΦΠΑ',
                  onTap: onPressMessage,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      );
    },
  );
}

Widget _buildOptionButton({
  required String icon,
  required String label,
  required String details,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF08C7F4), // Blue
                  Color(0xFF0765CB), // Lighter Blue
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SvgPicture.asset(
              icon,
              height: 30.0,
              width: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 20.0),
          Text(
            details,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),

          const SizedBox(height: 10.0),
        ],
      ),
    ),
  );
}
