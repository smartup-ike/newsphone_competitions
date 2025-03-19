import 'package:flutter/material.dart';
import 'package:newsphone_competitions/pages/intro_page.dart';
import 'package:newsphone_competitions/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: IntroPage(),
      theme: lightMode,
    );
  }
}