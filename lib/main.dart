import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:newsphone_competitions/pages/about_page.dart';
import 'package:newsphone_competitions/pages/fav_page.dart';
import 'package:newsphone_competitions/pages/info_page.dart';
import 'package:newsphone_competitions/pages/intro_page.dart';
import 'package:newsphone_competitions/pages/main_page.dart';
import 'package:newsphone_competitions/pages/search_page.dart';
import 'package:newsphone_competitions/pages/settings_page.dart';
import 'package:newsphone_competitions/pages/terms_page.dart';
import 'package:newsphone_competitions/provider/comp_provider.dart';
import 'package:newsphone_competitions/services/notifications_service.dart';
import 'package:newsphone_competitions/themes/theme_modes.dart';
import 'package:provider/provider.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 2));
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();

  final DatabaseHelper db = DatabaseHelper.instance;
  await db.database;

  runApp(
    ChangeNotifierProvider(
      create: (context) => CompetitionsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FutureBuilder(
        future: IsFirstRun.isFirstCall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or a splash screen
          } else {
            if (snapshot.data == true) {
              return IntroPage();
            } else {
              DatabaseHelper db = DatabaseHelper.instance;
              db.getFavorites().then((onValue) {
                if (onValue.isNotEmpty) {
                  for (var element in onValue) {
                    if (context.mounted) {
                      Provider.of<CompetitionsProvider>(
                        context,
                        listen: false,
                      ).toggleFilter(element['type'], true);
                    }
                  }
                }
              });
              return MainPage();
            }
          }
        },
      ),
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/main_page': (context) => const MainPage(),
        '/settings': (context) => const SettingsPage(),
        '/info_page': (context) => const InfoPage(),
        '/terms-page': (context) => const TermsPage(),
        '/fav-page': (context) => const FavPage(),
        '/search_page': (context) => const SearchPage(),
        '/about_page': (context) => const AboutAppPage(),
      },
    );
  }
}
