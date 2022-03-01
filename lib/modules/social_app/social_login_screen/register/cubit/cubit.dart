// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/layouts/shop_app/login/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/register/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/login_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';
import 'package:abdallah_flutter_funds/modules/social_app/social_login_screen/register/cubit/states.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<SocialRegisterState> {
  RegisterCubit() : super(SocialRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(email: email, uid: value.user!.uid, name: name, phone: phone);
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
      {required String email,
      required String uid,
      required String name,
      required String phone}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(SocialUserModel(
                name: name,
                email: email,
                phone: phone,
                uid: uid,
                image:
                    'https://image.freepik.com/free-photo/portrait-shocked-handyman-wearing-checkered-shirt-protective-eyewear-gloves-tool-belt-holding-rolled-paper-having-surprised-expression-realising-his-mistake-people-work-concept_273609-7916.jpg',
                cover:
                    'https://image.freepik.com/free-photo/raw-chicken-fillet-with-garlic-pepper-rosemary-wooden-chopping-board_1150-37784.jpg',
                bio: 'Write our bio...',
                isEmailVerified: false)
            .toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
