// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/components/constants.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/login/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/login_model.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<ShopLoginState>{
  LoginCubit() : super(ShopLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
      token = loginModel.data!.token!;
    }).catchError((error){
      print('no');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}