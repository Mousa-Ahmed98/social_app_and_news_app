// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:abdallah_flutter_funds/components/constants.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/chats/chats_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/feeds/feeds_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/new_post/new_post_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/settings/settings_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/users/users_screen.dart';
import 'package:abdallah_flutter_funds/models/social_app/comment_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/message_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/post_model.dart';
import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  String coverImageUrl = '';
  String profileImageUrl = '';

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      coverImageUrl = userModel!.cover!;
      profileImageUrl = userModel!.image!;
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('failed');
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> title = [
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(index) {
    if (index == 1) getAllUsers();
    if (index == 2)
      emit(SocialNewsPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickSuccessState());
    } else {
      print('No image is selected');
      emit(SocialProfileImagePickErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickSuccessState());
    } else {
      print('No image is selected');
      emit(SocialCoverImagePickErrorState());
    }
  }

  Future uploadProfileImage(name, bio, phone) async {
    emit(SocialLoadingUploadingUserDataState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        SocialUserModel model = SocialUserModel(
            name: name,
            phone: phone,
            email: userModel!.email,
            uid: userModel!.uid,
            image: value,
            cover: userModel!.cover,
            bio: bio,
            isEmailVerified: false);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update(model.toMap())
            .then((value) {
          profileImage = null;
          emit(SocialUploadProfileImageSuccessState());
          getUserData();
        }).catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
      }).catchError((error) {
        print('error in update user $error');
      });
    }).catchError((_) {});
  }

  Future uploadCoverImage(name, bio, phone) async {
    emit(SocialLoadingUploadingUserDataState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        SocialUserModel model = SocialUserModel(
            name: name,
            phone: phone,
            email: userModel!.email,
            uid: userModel!.uid,
            image: userModel!.image,
            cover: value,
            bio: bio,
            isEmailVerified: false);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update(model.toMap())
            .then((value) {
          coverImage = null;
          emit(SocialUploadCoverImageSuccessState());
          getUserData();
        }).catchError((error) {
          emit(SocialUploadCoverImageErrorState());
        });
      }).catchError((error) {
        print('error in update user $error');
      });
    }).catchError((_) {});
  }

  void updateUser({required name, required bio, required phone}) async {
    if (coverImage != null) {
      uploadCoverImage(name, bio, phone);
    }

    if (profileImage != null) {
      uploadProfileImage(name, bio, phone);
    }
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickSuccessState());
    } else {
      print('No image is selected');
      emit(SocialPostImagePickErrorState());
    }
  }

  Future uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImage = null;
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print('error in update user $error');
      });
    }).catchError((_) {});
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel?.name,
      image: userModel?.image,
      uid: userModel?.uid,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];

  Future<void> getPosts() async {
    posts = [];
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').get().then((value1) {
      value1.docs.forEach((element) {
        element.reference.collection('likes').get().then((value2) {
          element.reference.collection('comments').get().then((value3) {
            posts.add(PostModel.fromJson(element.data()));
            posts[posts.length - 1].postId = element.id;
            posts[posts.length - 1].likes = value2.docs.length;
            posts[posts.length - 1].comments = value3.docs.length;
            value2.docs.forEach((element) {
              if(element.id == userModel!.uid)
                posts[posts.length - 1].isLikedByMe = true;
            });
            print('is liked by me ${posts[posts.length - 1].isLikedByMe}');
            emit(SocialGetPostsSuccessState());
          }).catchError((error) {
            emit(SocialGetPostsErrorState(error.toString()));
            print('error is liked by me ${posts[posts.length - 1].isLikedByMe}');
          });
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error));
        });
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }

  void likePost(String postId) {
    emit(SocialLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error));
    });
  }

  void commentOnPost(String postId, String comment) {
    emit(SocialCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uid)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uid) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error));
      });
  }

  void sendMessage(MessageModel model) {
    model.senderId = userModel!.uid!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(model.receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
  
  List<CommentModel> comments = [];
  List<String> usersLikes = [];
  void getPostComments({required String postId}){
    comments = [];
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').get().then((value){
      value.docs.forEach((element) {
        element.reference.get().then((value){
          comments.add(CommentModel(id: element.id, comment: value.data()!['comment']));
          emit(SocialGetCommentsSuccessState());
          print(element.id);
        }).catchError((error){
          emit(SocialGetCommentsErrorState(error));
        });

      });
      emit(SocialGetCommentsSuccessState());
    }).catchError((error){
      emit(SocialGetCommentsErrorState(error));
    });
  }
  Future getPostLikes({required String postId}) async{
    usersLikes = [];
    emit(SocialGetLikesLoadingState());
    await FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').get().then((value){
      value.docs.forEach((element) {
        usersLikes.add(element.id);
        emit(SocialGetLikesSuccessState());
      });
    }).catchError((error){
      emit(SocialGetLikesErrorState(error.toString()));
    });
  }
}
