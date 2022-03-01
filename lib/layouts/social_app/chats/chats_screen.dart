import 'package:abdallah_flutter_funds/layouts/social_app/chat_details/chat_details_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) =>
      ConditionalBuilder(
        condition: SocialCubit.get(context).users.isNotEmpty,
        builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => const Divider(height: 2,),
            itemCount: SocialCubit.get(context).users.length
        ),
        fallback: (context) => Container(),
      ),
    );
  }

  Widget buildChatItem(SocialUserModel model, context){
    return InkWell(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatDetailsScreen(userModel: model,),));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                // ignore: prefer_const_constructors
                  model.image!),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              model.name!,
              style: const TextStyle(height: 1.4),
            ),

          ],
        ),
      ),
    );
  }
}
