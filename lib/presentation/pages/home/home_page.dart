import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/presentation/pages/notifications/notification_page.dart';
import '../../../logic/blocs/notifications/notifications_cubit.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationCubit>().loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NewsphoneTheme.neutralWhite,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: NewsphoneTheme.neutralWhite,
          appBar: HomePageAppBar(
            clickNotificationFunction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
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
        ),
      ),
    );
  }
}
