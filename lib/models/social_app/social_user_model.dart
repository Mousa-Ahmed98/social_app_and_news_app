import 'dart:core';
class SocialUserModel {
  String? name;
  String? email;
  String? uid;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.uid,
    this.phone,
    this.image,
    this.bio,
    this.cover,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name' : name,
      'email' : email,
      'uid' : uid,
      'phone' : phone,
      'image' : image,
      'bio' : bio,
      'cover' : cover,
      'isEmailVerified' : isEmailVerified,
    };
  }

}
