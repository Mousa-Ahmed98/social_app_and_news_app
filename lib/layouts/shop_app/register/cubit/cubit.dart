// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/layouts/shop_app/login/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/register/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/login_model.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<ShopRegisterState>{
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name' : name,
      'email' : email,
      'password' : password,
      'phone' : phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print('no');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}