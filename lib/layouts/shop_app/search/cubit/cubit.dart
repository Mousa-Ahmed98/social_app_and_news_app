import 'package:abdallah_flutter_funds/components/constants.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/search_model.dart';
import 'package:abdallah_flutter_funds/shared/network/end_points.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text' : text
    }
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      print(model!.data!.data[0].name);
      emit(SearchSuccessState());
    }).catchError((onError){
      print(onError);
      emit(SearchErrorState());
    });
  }
}