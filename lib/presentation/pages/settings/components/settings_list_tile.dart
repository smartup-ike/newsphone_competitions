import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/core/themes/newsphone_typography.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: NewsphoneTheme.neutralWhite,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 1.0,
          ),
          title: Text(title, style: NewsphoneTypography.body15SemiBold),
          subtitle: Text(
            subtitle,
            style: NewsphoneTypography.body13Medium.copyWith(
              color: NewsphoneTheme.neutral30,
            ),
          ),
          leading: Icon(leadingIcon, color: NewsphoneTheme.neutral40),
          trailing:
              trailingWidget ?? Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}
