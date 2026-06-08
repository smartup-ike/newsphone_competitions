import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:newsphone_competitions/data/services/api_service.dart';

import '../../../../core/themes/newsphone_theme.dart';
import '../../../../core/themes/newsphone_typography.dart';

class VersionInfo extends StatefulWidget {
  const VersionInfo({super.key});

  @override
  State<VersionInfo> createState() => _VersionInfoState();
}

class _VersionInfoState extends State<VersionInfo> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 2)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTapTime = now;

    if (_tapCount >= 8) {
      _tapCount = 0;
      _showRegisterDeviceDialog();
    } else if (_tapCount >= 3) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Απομένουν ${8 - _tapCount == 1 ? "1 βήμα" : "${8 - _tapCount} βήματα"} για την εγγραφή δοκιμαστικής συσκευής.',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _showRegisterDeviceDialog() async {
    final TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: NewsphoneTheme.primary50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.developer_mode,
                          color: NewsphoneTheme.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Εγγραφή Δοκιμαστικής Συσκευής',
                          style: NewsphoneTypography.heading7Bold.copyWith(
                            color: NewsphoneTheme.neutral10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Εισάγετε ένα αναγνωρίσιμο όνομα για αυτήν τη συσκευή (π.χ. "Κινητό Γιώργου") για να την εγγράψετε στο σύστημα.',
                    style: NewsphoneTypography.body13Medium.copyWith(
                      color: NewsphoneTheme.neutral35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Όνομα Συσκευής',
                      hintText: 'π.χ. iPhone 15 Pro Max',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: NewsphoneTheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Παρακαλώ εισάγετε ένα όνομα';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: NewsphoneTheme.neutral70,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Ακύρωση',
                            style: NewsphoneTypography.button15Medium.copyWith(
                              color: NewsphoneTheme.neutral30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final name = nameController.text.trim();
                              Navigator.pop(context);
                              _registerDevice(name);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: NewsphoneTheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: Text(
                            'Εγγραφή',
                            style: NewsphoneTypography.button15Medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _registerDevice(String deviceName) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
    }

    if (token == null) {
      if (mounted) {
        Navigator.pop(context); // dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Αποτυχία ανάκτησης του FCM Token.')),
        );
      }
      return;
    }

    try {
      final apiService = ApiService();
      await apiService.registerTestDevice(name: deviceName, fcmToken: token);

      if (mounted) {
        Navigator.pop(context); // dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Η συσκευή εγγράφηκε με επιτυχία!'),
            backgroundColor: NewsphoneTheme.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Σφάλμα κατά την εγγραφή: $e'),
            backgroundColor: NewsphoneTheme.error30,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        if (snapshot.hasError) {
          return const Text('Failed to load version');
        }
        final String version = snapshot.data ?? 'N/A';
        return GestureDetector(
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Text(
              'Version $version',
              style: NewsphoneTypography.body13Medium.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.inverseSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
