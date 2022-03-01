import 'package:abdallah_flutter_funds/components/components.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).sport;
        print(list.length);
        return ConditionalBuilder(
          condition: state is! NewsGetSportsLoadingState,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder:(context, index) =>  buildArticleItem(list[index], context),
              separatorBuilder:(context, index) =>  const SizedBox(height: 10,),
              itemCount: list.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
