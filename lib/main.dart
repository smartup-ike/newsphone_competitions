import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsphone_competitions/logic/blocs/categories/categories_cubit.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'data/models/notification.dart';
import 'data/services/api_service.dart';
import 'package:newsphone_competitions/data/services/notifications_services.dart';
import 'logic/blocs/contest/contests_cubit.dart';
import 'logic/blocs/deals/deals_cubit.dart';
import 'logic/blocs/notifications/notifications_cubit.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Hive.initFlutter();
  Hive.registerAdapter(AppNotificationAdapter());
  var box = await Hive.openBox<AppNotification>('notifications');

  final notification = AppNotification(
    title: message.notification?.title ?? '',
    body: message.notification?.body ?? '',
    topicName: message.data['topic_name'] ?? '',
    sentAt: DateTime.now(),
    id: int.tryParse(message.messageId ?? '') ?? 0,
    linkedContestId: int.tryParse(message.data['id'] ?? '') ?? 0,
    linkedDealId: int.tryParse(message.data['id'] ?? ''),
    type: message.data['type'],
    isRead: false,
  );
  await box.add(notification);
  await NotificationService.showNotificationStatic(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final apiService = ApiService();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  Hive.registerAdapter(AppNotificationAdapter());
  await Hive.openBox<AppNotification>('notifications');

  await NotificationService.init();

  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiService});

  final ApiService apiService;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContestsCubit>(
          create: (context) => ContestsCubit(apiService)..init(),
        ),
        BlocProvider<DealsCubit>(
          create: (_) => DealsCubit(apiService)..fetchDeals(),
        ),
        BlocProvider<NotificationCubit>(
          create: (_) => NotificationCubit(apiService),
        ),
        BlocProvider<CategoriesCubit>(
          create: (_) => CategoriesCubit(apiService),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: '14614 App',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
        navigatorObservers: [observer],
        home: HomePage(),
        routes: {},
      ),
    );
  }
}
