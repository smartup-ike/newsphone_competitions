import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'core/themes/theme_modes.dart';
import 'data/models/notification.dart';
import 'data/services/api_service.dart';
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
  final apiService = ApiService();

  await Hive.initFlutter();
  Hive.registerAdapter(AppNotificationAdapter());
  await Hive.openBox<AppNotification>('notifications');

  await NotificationService.init();

  runApp(MyApp(apiService: apiService,));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.apiService});
  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContestsCubit>(
          create: (context) => ContestsCubit()..init(apiService),
        ),BlocProvider<DealsCubit>(
          create: (_) => DealsCubit()..fetchDeals(apiService),
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
