// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/components/constants.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/categories/categories_screen.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/favourites/favourites_screen.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/home_model.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/products/products_screen.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/settings/settings_screen.dart';
import 'package:abdallah_flutter_funds/models/shop_app/categories_model.dart';
import 'package:abdallah_flutter_funds/models/shop_app/change_favorites_model.dart';
import 'package:abdallah_flutter_funds/models/shop_app/login_model.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    if (index == 3)
      getUserData();
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favourites = {};

  HomeModel? homeModel;

  void getData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(HOME, token: token).then((value) {
      emit(ShopSuccessHomeDataState());
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners[0].image);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id!: element.inFavourites!});
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(CATEGORIES, token: token).then((value) {
      emit(ShopSuccessCategoriesState());
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, data: {
      'product_id': productId,
    },
      token: token,
    )
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favourites[productId] = !favourites[productId]!;
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    })
        .catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(PROFILE, token: token).then((value) {
      print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error);
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
    }).then((value) {
      print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error);
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
