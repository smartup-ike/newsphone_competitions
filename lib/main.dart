import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:newsphone_competitions/pages/intro_page.dart';
import 'package:newsphone_competitions/pages/main_page.dart';
import 'package:newsphone_competitions/pages/settings_page.dart';
import 'package:newsphone_competitions/provider/sqlb_provider.dart';
import 'package:newsphone_competitions/themes/light_mode.dart';
import 'package:provider/provider.dart';

import 'database_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  bool firstCall = await IsFirstRun.isFirstCall();
  if (firstCall) {
    final DatabaseHelper db = DatabaseHelper.instance;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => SQLBProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const IntroPage(),
      theme: lightMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/main_page': (context) => const MainPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
