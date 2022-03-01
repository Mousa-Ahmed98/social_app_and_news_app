// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:abdallah_flutter_funds/layouts/social_app/comments/comments_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/social_app/post_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onFeedsRefresh(context),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            width: double.infinity,
                            image: NetworkImage(
                                'https://image.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg'),
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                          Text(
                            'Communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildCardItem(cubit.posts[index], context),
                        separatorBuilder: (context, index) => const SizedBox(height: 10,),
                        itemCount: cubit.posts.length
                    ),
                    const SizedBox(height: 8,)
                  ],
                ),
              ),
          fallback: (context) => Container(),
        );
        },
      ),
    );
  }

  Widget buildCardItem(PostModel model, context) {
    var commentController = TextEditingController();
    return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                      model.image!),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name!,
                          style: const TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                    Text(
                      model.dateTime!,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 20,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              color: Colors.grey[300],
              height: 1,
              width: double.infinity,
            ),
          ),
          Text(
            model.text!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_development',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_development',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software_development',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
          if(model.postImage!.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 16
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        model.postImage!),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      SocialCubit.get(context).getPostLikes(postId: model.postId!).then((value){
                        displayPostLikes(context,
                        );
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).primaryColor,
                            size: 18,),
                          Text(' ${model.likes}', style: Theme.of(context).textTheme.caption,),

                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      displayPostComments(context, model.postId!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.mark_chat_unread,
                            color: Colors.blue,
                            size: 18,
                          ),
                          Text(' ${model.comments} comment', style: Theme.of(context).textTheme.caption,),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            SocialCubit.get(context).userModel!.image!),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (value) {
                            SocialCubit.get(context).commentOnPost(model.postId!, value);
                            commentController.text = '';
                          },
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: 'write a comment...',
                            border: InputBorder.none,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  if(!model.isLikedByMe)
                  SocialCubit.get(context).likePost(model.postId!);
                },
                child: Row(
                  children: [
                    Icon(
                      model.isLikedByMe? Icons.favorite_outlined : Icons.favorite_outline,
                      color: Theme.of(context).primaryColor,
                      size: 18,),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
  }

  Future<void> onFeedsRefresh(context) async{
    await SocialCubit.get(context).getPosts();
  }

  void displayPostComments(context,String postId){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: postId,),),
    );
  }

  void displayPostLikes(context){
    var usersLikes = SocialCubit.get(context).usersLikes;
    var users = SocialCubit.get(context).users;
    print(users.length);
    showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 550,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.uid == usersLikes[index]? SocialCubit.get(context).userModel!.image!
                              : users.firstWhere((element) => element.uid == usersLikes[index]).image!
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(SocialCubit.get(context).userModel!.uid == usersLikes[index]? SocialCubit.get(context).userModel!.name!
                          : users.firstWhere((element) => element.uid == usersLikes[index]).name!),
                      const Spacer(),
                      Icon(Icons.favorite_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 18,)
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  itemCount: usersLikes.length,
              ),
            ),
          ),
        ),
    );
  }


}
