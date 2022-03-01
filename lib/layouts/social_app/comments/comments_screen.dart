// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/social_app/comment_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialCubit.get(context);
    bloc.getPostComments(postId: postId);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
        builder: (context, state) => ConditionalBuilder(
            condition: bloc.comments.isNotEmpty,
            builder: (context) => buildCommentsWidget(context, bloc.comments),
            fallback: (context) =>  const Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }

  Widget buildCommentsWidget(context, List<CommentModel> commentsList){
    final bloc = SocialCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) => Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  bloc.userModel!.uid == commentsList[index].id? bloc.userModel!.image! :
                  bloc.users.firstWhere((element){
                    if(element.uid == commentsList[index].id || bloc.userModel!.uid == commentsList[index].id)
                      return true;
                    else
                      return false;
                  }).image!,
                )
              ),
              Container(
                width: 200,
                height: 75,
                margin: const EdgeInsetsDirectional.only(start: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 12,
                    start: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          bloc.userModel!.uid == commentsList[index].id? bloc.userModel!.name! :
                          bloc.users.firstWhere((element) {
                        if(element.uid == commentsList[index].id || bloc.userModel!.uid == commentsList[index].id)
                          return true;
                        else
                          return false;
                      }).name!, style: const TextStyle(color: Colors.blueAccent),),
                      Align(alignment: AlignmentDirectional.centerStart,child: Text(commentsList[index].comment!)),
                    ],
                  ),
                ),
              )
            ],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 15,),
          itemCount: commentsList.length,
      ),
    );
  }
}
