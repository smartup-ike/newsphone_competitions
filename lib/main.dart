import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsphone_competitions/logic/blocs/categories/categories_cubit.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'data/models/notification.dart';
import 'data/services/api_service.dart';
import 'package:newsphone_competitions/data/services/notifications_services.dart';
import 'firebase_options.dart';
import 'logic/blocs/auth/auth_cubit.dart';
import 'logic/blocs/contest/contests_cubit.dart';
import 'logic/blocs/coupons/cupons_cubit.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final apiService = ApiService();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  Hive.registerAdapter(AppNotificationAdapter());
  await Hive.openBox<AppNotification>('notifications');

  await NotificationService.init();

  await NotificationService.subscribeToTopic('14614Notifications');

  await NotificationService.loadMissedNotifications();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
        BlocProvider<DealsCubit>(create: (_) => DealsCubit(apiService)..init()),
        BlocProvider<CategoriesCubit>(
          create: (_) => CategoriesCubit(apiService)..init(),
        ),
        BlocProvider<NotificationCubit>(
          create: (_) => NotificationCubit(apiService),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(FirebaseAuth.instance, apiService),
        ),
        BlocProvider(
          create:
              (_) => CouponsCubit(FirebaseAuth.instance, apiService)..init(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: '14614 App',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // lock font size
              devicePixelRatio:
                  MediaQuery.of(
                    context,
                  ).devicePixelRatio, // optional, keeps pixel ratio fixed
              size:
                  MediaQuery.of(context).size, // locks the logical screen size
            ),

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
