import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  NewsLayout({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, NewsStates state){},
      builder: (BuildContext context, NewsStates state){
        var cubit = NewsCubit.get(context);
        double displayWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30.0,
                ),
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_sharp,
                    size: 30.0,
                  )
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            height: displayWidth * .155,
            margin: EdgeInsets.all(displayWidth * .05),
            decoration: BoxDecoration(
              color: AppCubit
                  .get(context)
                  .isDark  ? HexColor('#212128') : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  cubit.changeIndex(index);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == cubit.currentIndex
                          ? displayWidth * .32
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == cubit.currentIndex ? displayWidth * .12 : 0,
                        width: index == cubit.currentIndex ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color: index == cubit.currentIndex
                              ? Colors.blueAccent.withOpacity(.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == cubit.currentIndex
                          ? displayWidth * .31
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width:
                                index == cubit.currentIndex ? displayWidth * .13 : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == cubit.currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == cubit.currentIndex
                                      ? cubit.listOfStrings[index]
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width:
                                index == cubit.currentIndex ? displayWidth * .03 : 20,
                              ),
                              Icon(
                                cubit.listOfIcons[index],
                                size: displayWidth * .076,
                                color: index == cubit.currentIndex
                                    ? Colors.blueAccent
                                    : AppCubit
                                    .get(context)
                                    .isDark ? Colors.grey : Colors.black45,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}