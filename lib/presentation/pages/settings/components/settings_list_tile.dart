import 'package:flutter/material.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 1.0,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF555758),
            ),
          ),
          leading: Icon(leadingIcon, color: Colors.black54),
          trailing:
              trailingWidget ?? Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}
