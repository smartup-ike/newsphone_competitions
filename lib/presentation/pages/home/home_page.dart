import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:newsphone_competitions/presentation/pages/notifications/notification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/themes/newsphone_typography.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/app_bar.dart';
import '../contests/contests_page.dart';
import '../coupons/sing_in_page.dart';
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

  Future<void> showFreeCouponsDialog(BuildContext context) async {
    // Get a shared preferences instant.
    final prefs = await SharedPreferences.getInstance();

    // If the app has been opened before hasAppBeenOpenedBefore will be true, otherwise it will be false.
    final hasAppBeenOpenedBefore = prefs.containsKey('hasAppBeenOpenedBefore');

    if (hasAppBeenOpenedBefore == false) {
      // Set hasAppBeenOpenedBefore.
      await prefs.setString("hasAppBeenOpenedBefore", "true");

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'SUPER ΔΩΡΟ!',
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.heading3Bold.copyWith(
                      color: NewsphoneTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Θέλετε να εξασφαλίσετε 10 κουπόνια - συμμετοχές σε μεγάλους διαγωνισμούς εντελώς ΔΩΡΕΑΝ;",
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.heading6Bold,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Με 10 δωρεάν κουπόνια, δεκαπλασιάζετε τις πιθανότητες να κερδίσετε τα μεγάλα έπαθλα που προσφέρουν οι  διαγωνισμοί μας. Αρκεί μόνο ένα γρήγορο βήμα για να τα αποκτήσετε εντελώς δωρεάν.",
                    textAlign: TextAlign.center,
                    style: NewsphoneTypography.body13Regular.copyWith(
                      color: NewsphoneTheme.neutral40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF054279),
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "ΝΑΙ, θέλω 10 κουπόνια δωρεάν!",
                            style: TextStyle(
                              color: Color(0xFF054279),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF054279),
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "ΟΧΙ",
                            style: TextStyle(
                              color: Color(0xFF054279),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    showFreeCouponsDialog(context);
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: NewsphoneTheme.neutralWhite,
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                HomePageAppBar(
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
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ],
          body: _pages[_selectedIndex],
        ),
        bottomNavigationBar: HomePageBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
