import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens=[
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
    const SettingsScreen(),
  ];

  List<IconData> listOfIcons = [
    Icons.currency_exchange,
    Icons.science_rounded,
    Icons.sports,
    Icons.settings
  ];

  List<String> listOfStrings = [
    'Business',
    'Science',
    'Sports',
    'Settings',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if(index == 1) {
      getScience();
    }
    if(index == 2) {
      getSports();
    }
    HapticFeedback.lightImpact();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [] ;

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'94df0e7857444d2da7883d05fd4cbe10',
      },
    ).then((value){
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError){
      emit(NewsGetBusinessErrorState(onError));
    });
  }

  List<dynamic> science = [] ;

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '94df0e7857444d2da7883d05fd4cbe10',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        emit(NewsGetScienceErrorState(onError));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [] ;

  void getSports(){

    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'94df0e7857444d2da7883d05fd4cbe10',
        },
      ).then((value){
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((onError){
        emit(NewsGetSportsErrorState(onError));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> search = [] ;

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search = [];
    if(search.isEmpty){
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey':'94df0e7857444d2da7883d05fd4cbe10',
        },
      ).then((value){
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((onError){
        emit(NewsGetSearchErrorState(onError));
      });
    }else{
      emit(NewsGetSearchSuccessState());
    }
  }
}

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}){
    if(fromShared != null) {
      isDark=fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      });
    }
  }
}