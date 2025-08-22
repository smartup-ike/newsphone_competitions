import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator
        }
        if (snapshot.hasError) {
          return const Text('Failed to load version'); // Handle errors
        }
        final String version = snapshot.data ?? 'N/A';
        return Text(
          'Version $version',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.6),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}