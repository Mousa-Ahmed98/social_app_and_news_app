import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);
  static const String route_name = 'new_post_screen';

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(context: context, title: 'Create Post', actions: [
          TextButton(
            onPressed: () {
              if (SocialCubit.get(context).postImage == null) {
                print('here');
                SocialCubit.get(context).createPost(
                  dateTime: DateTime.now().toString(),
                  text: textController.text,
                );
              } else {
                SocialCubit.get(context).uploadPostImage(
                  dateTime: DateTime.now().toString(),
                  text: textController.text,
                );
              }
            },
            child: const Text('Post'),
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoadingState)
              const LinearProgressIndicator(),
              if(state is SocialCreatePostLoadingState)
              const SizedBox(height: 10,),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/unimpressed-unshaven-caucasian-guy-points-himself-asks-who-me-has-calm-face-expression-wears-red-sweatshirt-listens-audio-via-headset-shows-new-bought-outfit-poses-pink-wall_273609-42390.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Mousa Abdelnaby',
                      style: TextStyle(height: 1.4),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'What\'s in your mind...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              if(SocialCubit.get(context).postImage != null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(4),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(SocialCubit.get(context).postImage!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 15,
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 16,
                          ),
                        )),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('# tags'),
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
