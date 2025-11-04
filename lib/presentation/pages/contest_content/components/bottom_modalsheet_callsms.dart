import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

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
        decoration: BoxDecoration(
          color: NewsphoneTheme.neutral95,
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
            Text(
              'Διάλεξε τον τρόπο συμμετοχής',
              style: NewsphoneTypography.heading6Bold,
            ),
            const SizedBox(height: 8.0),
            // Subtitle
            Text(
              'Επίλεξε τρόπο συμμετοχής στον διαγωνισμό.\nΚάλεσε μας ή στείλε μήνυμα.',
              textAlign: TextAlign.center,
              style: NewsphoneTypography.body13SemiBold.copyWith(
                color: NewsphoneTheme.neutral40,
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [NewsphoneTheme.primary, NewsphoneTheme.primary],
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
