import 'package:abdallah_flutter_funds/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super (CounterInitialState());

  int counter = 0;

  static CounterCubit get(context) => BlocProvider.of(context);

  void plus(){
    counter++;
    emit(CounterPlusState());
  }

  void minus(){
    counter--;
    emit(CounterMinusState());
  }

  bool isDark = true;
  void changeMode(){
    isDark = !isDark;
    emit(ModeChangeState());
  }

}