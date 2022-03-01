import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/social_app/message_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);
  static const String route_name = 'chat_details_screen';

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                userModel!.image!
              ),
            ),
            const SizedBox(width: 15,),
            Text(
              userModel!.name!,
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          var cubit = SocialCubit.get(context);
          cubit.getMessages(receiverId: userModel!.uid!);
          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) => ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                         physics: const BouncingScrollPhysics(),
                           itemBuilder: (context, index){
                             if(cubit.messages[index].senderId != userModel!.uid){
                               return buildMyMessage(context, cubit.messages[index]);
                             }
                             else{
                               return buildReceivedMessage(context, cubit.messages[index]);

                             }
                           },
                           separatorBuilder: (context, index) =>  const SizedBox(height: 15,),
                           itemCount: cubit.messages.length,
                       ),
                     ),
                      const Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message...'
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Theme.of(context).primaryColor,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(MessageModel(
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: userModel!.uid,
                                  ));
                                  messageController.text = '';
                                },
                                minWidth: 1,
                                child: const Icon(Icons.send, size: 16, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) =>  const Center(child: CircularProgressIndicator()),
            ),
          );
        }
      ),
    );
  }

  Align buildReceivedMessage(context, MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(messageModel.text!, style: Theme.of(context).textTheme.subtitle1,),
    ),
  );
  Align buildMyMessage(context, MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.6),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(messageModel.text!, style: Theme.of(context).textTheme.subtitle1,),
    ),
  );
}
