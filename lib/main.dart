import 'package:flutter/material.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'core/themes/theme_modes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      title: '14614 App',
      home: HomePage(),
      routes: {},
    );
  }
}
