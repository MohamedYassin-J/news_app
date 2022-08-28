import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../layout/news_layout.dart';
import '../../shared/cubit/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000),(){});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NewsLayout()
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCubit
          .get(context)
          .isDark  ? HexColor('#212121') : Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.newspaper_rounded,
                        size: 120.0,
                        color: AppCubit
                            .get(context)
                            .isDark ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 10.0,),
                      Text(
                        'News App',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: AppCubit
                              .get(context)
                              .isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
