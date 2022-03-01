import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/search_screen.dart';
import 'package:abdallah_flutter_funds/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);
  static const String route_name = 'shop_layout';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, SearchScreen.route_name);
                },
                icon: const Icon(Icons.search),
            )
          ],
        ),
        body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => cubit.changeBottom(index),
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
      );
      },
    );
  }

  void signOut(){
    CacheHelper.removeData(key: 'token').then((value) {
      if(value){
        //navigate
      }
      else
        {

        }
    });
  }
}
