import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'core/themes/theme_modes.dart';
import 'data/services/notifications_services.dart';
import 'logic/blocs/contest/contests_cubit.dart';
import 'logic/blocs/deals/deals_cubit.dart';
import 'logic/blocs/notifications/notifications_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContestsCubit>(
          create: (context) => ContestsCubit()..fetchAndSortContests(),
        ),BlocProvider<DealsCubit>(
          create: (_) => DealsCubit()..fetchDeals(),
        ),
        BlocProvider<NotificationCubit>(
          create: (_) => NotificationCubit(),
        ),

      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        title: '14614 App',
        home: HomePage(),
        routes: {},
      ),
    );
  }
}
