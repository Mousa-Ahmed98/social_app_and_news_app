// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  static const route_name = 'edit_profile_screen';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
              onPressed: () {
                SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text);
                //Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: coverImage != null
                                    ? FileImage(coverImage)
                                    : NetworkImage(userModel.cover!)
                                        as ImageProvider,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                  ),
                                )),
                          )
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage(userModel.image!)
                                        as ImageProvider,
                              ),
                            ),
                            Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(state is SocialLoadingUploadingUserDataState)
                  const LinearProgressIndicator(),
                if(state is SocialLoadingUploadingUserDataState)
                  const SizedBox(height: 10,),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.toString().isEmpty)
                      return 'Name must not be empty';
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.toString().isEmpty)
                      return 'Bio must not be empty';
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text('Bio'),
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.toString().isEmpty)
                      return 'Phone number must not be empty';
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text('Phone'),
                      prefixIcon: Icon(Icons.call),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
