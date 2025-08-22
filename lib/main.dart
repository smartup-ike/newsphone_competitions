import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/presentation/pages/home/home_page.dart';
import 'core/themes/theme_modes.dart';
import 'logic/blocs/contest/contests_cubit.dart';
import 'logic/blocs/deals/deals_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
