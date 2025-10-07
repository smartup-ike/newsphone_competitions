import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showContestPhoneSmsBottomSheet(
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
              'Διάλεξε τον τρόπο συμμετοχής',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            // Subtitle
            const Text(
              'Επίλεξε τρόπο συμμετοχής στον διαγωνισμό.\nΚάλεσε μας ή στείλε μήνυμα.',
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
                  label: 'Κάλεσε',
                  onTap: onPressDial,
                ),
                _buildOptionButton(
                  icon: 'assets/images/icons/ChatCircleDots.svg',
                  label: 'Στείλε SMS',
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

          const SizedBox(height: 50.0),
        ],
      ),
    ),
  );
}
