import 'package:abdallah_flutter_funds/components/components.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String route_name = 'search_screen';
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List search = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  NewsCubit.get(context).getSearch(value.toString());
                },
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),          validator: ( value) {
                  if(value.toString().isEmpty){
                    return 'must not be empty';
                  }
                  else
                    return null;
                },
              ),
            ),
            ConditionalBuilder(
              condition: state is! NewsGetSearchLoadingState,
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) => search[index],
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                  itemCount:search.length
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator(),),

            ),
          ],
        ),
      );
      },
    );
  }
}
