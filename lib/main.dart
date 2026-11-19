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
import 'dart:async';

import 'core/config/app_env.dart';
import 'data/demo/demo_data.dart';
import 'data/services/brand_service.dart';
import 'flavors/flavor_config.dart';
import 'logic/blocs/auth/auth_cubit.dart';
import 'logic/blocs/contest/contests_cubit.dart';
import 'logic/blocs/coupons/cupons_cubit.dart';
import 'logic/blocs/deals/deals_cubit.dart';
import 'logic/blocs/notifications/notifications_cubit.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(AppNotificationAdapter());
  }
  // Close the box after writing so this isolate never holds a stale copy.
  await NotificationService.storeRemoteMessage(message, closeBox: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavor = FlavorConfig.instance;
  if (flavor.firebaseEnabled) {
    await Firebase.initializeApp(options: flavor.firebaseOptions!());
  }

  final apiService = ApiService();

  if (flavor.firebaseEnabled) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  await Hive.initFlutter();
  Hive.registerAdapter(AppNotificationAdapter());
  await Hive.openBox<AppNotification>(NotificationService.notificationsBoxName);

  await NotificationService.init();

  // Station numbers + topic: last saved values now, fresh ones from the
  // backend in the background (see BrandService).
  await BrandService.loadCached();
  await NotificationService.subscribeToTopic(BrandService.current.generalTopic);
  if (!DemoData.enabled) unawaited(_refreshBrand(apiService));

  await NotificationService.loadMissedNotifications();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(apiService: apiService));
}

/// Gets fresh station values; if the topic changed, moves the subscription.
Future<void> _refreshBrand(ApiService api) async {
  final previous = await BrandService.refresh(api.fetchBrand);
  if (previous == null) return;
  final topic = BrandService.current.generalTopic;
  if (previous.generalTopic != topic) {
    await NotificationService.unsubscribeFromTopic(previous.generalTopic);
    await NotificationService.subscribeToTopic(topic);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiService});

  final ApiService apiService;

  /// `null` for apps without Firebase set up yet (login is then disabled).
  static FirebaseAuth? get _firebaseAuth =>
      FlavorConfig.instance.firebaseEnabled ? FirebaseAuth.instance : null;
  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
  static final List<NavigatorObserver> _observers = [
    if (FlavorConfig.instance.firebaseEnabled)
      FirebaseAnalyticsObserver(analytics: analytics),
  ];

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
          create: (_) => NotificationCubit(apiService)..init(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(_firebaseAuth, apiService),
        ),
        BlocProvider(
          create: (_) => CouponsCubit(_firebaseAuth, apiService)..init(),
        ),
      ],
      child: SafeArea(
        top: false,
        bottom: true,
        child: MaterialApp(
          navigatorKey: NotificationService.navigatorKey,
          themeMode: ThemeMode.light,
          theme: FlavorConfig.instance.materialTheme(),
          debugShowCheckedModeBanner: false,
          title: '${FlavorConfig.instance.appName} App',
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0, // lock font size
                devicePixelRatio:
                    MediaQuery.of(
                      context,
                    ).devicePixelRatio, // optional, keeps pixel ratio fixed
                size:
                    MediaQuery.of(
                      context,
                    ).size, // locks the logical screen size
              ),

              child:
                  AppEnv.isProduction
                      ? child!
                      // Non-production backend: show a corner ribbon so a
                      // staging build is never mistaken for the real app.
                      : Directionality(
                        textDirection: TextDirection.ltr,
                        child: Banner(
                          message: AppEnv.name.toUpperCase(),
                          location: BannerLocation.topEnd,
                          child: child!,
                        ),
                      ),
            );
          },
          navigatorObservers: _observers,
          home: HomePage(),
          routes: {},
        ),
      ),
    );
  }
}
