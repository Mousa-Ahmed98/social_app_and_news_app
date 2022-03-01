// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/states.dart';
import 'package:abdallah_flutter_funds/modules/news_app/science/business/business_screen.dart';
import 'package:abdallah_flutter_funds/modules/news_app/science/science_screen.dart';
import 'package:abdallah_flutter_funds/modules/news_app/science/sports/sports_screen.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    //const SettingsScreen(),
  ];

  void changeBottomNavBar(index){
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      query: {
        'country' : 'eg',
        'category' : 'business',
        'apikey' : '65f7f556ec76449fa7dc7c0069f040ca',
      }
      ,
    ).then((value) {
      print(value);
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print("wdw");
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      query: {
        'country' : 'eg',
        'category' : 'sports',
        'apikey' : '65f7f556ec76449fa7dc7c0069f040ca',
      }
      ,
    ).then((value) {

      sport = value.data['articles'];
      print(sport[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      query: {
        'country' : 'eg',
        'category' : 'science',
        'apikey' : '65f7f556ec76449fa7dc7c0069f040ca',
      }
      ,
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
  List<dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      'v2/everything',
      query: {
        'q' : value,
        'apikey' : '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}