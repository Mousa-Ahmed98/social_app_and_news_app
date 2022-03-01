import 'package:abdallah_flutter_funds/cubit/cubit_provider.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/newsapp/cubit/states.dart';
import 'package:abdallah_flutter_funds/modules/news_app/science/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SearchScreen())
                );
               },
              icon: const Icon(Icons.search)),
              IconButton(onPressed: (){
                CounterCubit.get(context).changeMode();
              },
                  icon: const Icon(Icons.brightness_4_rounded)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),

        );
        },
    );
  }
}
