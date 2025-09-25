import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/about/about_page.dart';
import 'package:newsphone_competitions/presentation/pages/preferences/prefernces_page.dart';
import 'package:newsphone_competitions/presentation/pages/terms_page/terms_page.dart';

import '../../../core/constans/constants.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
import 'components/settings_list_tile.dart';
import 'components/version_info.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _allowNotifications = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      _allowNotifications =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            floating: false,
            pinned: true,
            expandedHeight: 60.0,
            centerTitle: true,
            title: Text(
              'Ρυθμίσεις',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: Colors.grey[300], height: 1.0),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: const Text(
                  "ΓΕΝΙΚΕΣ ΡΥΘΜΙΣΕΙΣ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF121212),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SettingsListTile(
                title: "Προτιμήσεις διαγωνισμών",
                subtitle: "Επιλέξτε τις κατηγορίες που επιθυμείτε",
                leadingIcon: Icons.star_border,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreferencesPage(),
                    ),
                  );
                },
              ),
              SettingsListTile(
                title: "Ειδοποιήσεις",
                subtitle: "Λάβετε ειδοποιήσεις για διαγωνισμούς και προσφορές!",
                leadingIcon: Icons.notifications_none,
                trailingWidget: Switch(
                  value: _allowNotifications,
                  onChanged: (bool value) async {
                    setState(() {
                      _allowNotifications = value;
                    });

                    final cubit = context.read<NotificationCubit>();

                    if (value) {
                      await cubit.toggleTopic(defaultTopic);
                    } else {
                      await cubit.unsubscribeFromAllTopics();
                    }
                  },
                  activeColor: Colors.blue,
                ),
              ),
              SettingsListTile(
                title: "Σχετικά",
                subtitle: "Τι είναι η εφαρμογή 14614",
                leadingIcon: Icons.info_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "ΑΠΟΡΡΗΤΟ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF121212),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SettingsListTile(
                title: "Όροι Χρήσης",
                subtitle: "Διαβάστε τους όρους χρήσης",
                leadingIcon: Icons.shield_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TermsPage()),
                  );
                },
              ),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Έκδοση εφαρμογής',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const VersionInfo(),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 20)),
        ],
      ),
    );
  }
}
