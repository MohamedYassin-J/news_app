import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_layout.dart';
import 'modules/splashScreen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Important
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  //
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  const MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness(),),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(
            fromShared: isDark,
          ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                button: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              iconTheme: const IconThemeData(
                size: 30.0,
                color: Colors.black,
              ),
            ),
            darkTheme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('#212121'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              scaffoldBackgroundColor: HexColor('#212121'),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                bodyText2: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                button: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(
                size: 30.0,
                color: Colors.white,
              ),
            ),
            themeMode: AppCubit
                .get(context)
                .isDark ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}