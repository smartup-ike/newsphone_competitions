import 'package:flutter/material.dart';
import 'package:newsphone_competitions/data/services/notifications_services.dart';
import 'package:newsphone_competitions/presentation/pages/notifications/notification_page.dart'; // Ensure this import is correct
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/app_bar.dart';
import '../contests/contests_page.dart';
import '../deals/deals_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [ContestsPage(), DealsPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.listenForMessages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomePageAppBar(
        clickNotificationFunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          );
        },
        clickDrawerFunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: HomePageBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
