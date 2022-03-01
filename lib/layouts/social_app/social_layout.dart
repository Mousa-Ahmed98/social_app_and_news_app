// ignore_for_file: constant_identifier_names, avoid_print

import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/new_post/new_post_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);
  static const String route_name = 'social_layout';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewsPostState){
          Navigator.pushNamed(context, NewPostScreen.route_name);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text(cubit.title[cubit.currentIndex].toString()),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
              ),
            ],
          ),
          );
      });
  }
}
