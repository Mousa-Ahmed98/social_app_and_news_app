// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/components/constants.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/login/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/login_model.dart';
import 'package:abdallah_flutter_funds/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/local/cache_helper.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}){
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(SocialLoginSuccessState(value.user?.uid));
      CacheHelper.saveData(key: 'uId', value: value.user?.uid);
      print(value.user?.email);
      print(value.user?.uid);
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

}