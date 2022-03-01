import 'package:abdallah_flutter_funds/models/social_app/social_user_model.dart';

class PostModel{
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;
  int likes = 0;
  int comments = 0;
  bool isLikedByMe = false;
  PostModel({
    this.name,
    this.uid,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postId,
    this.isLikedByMe = false,
});

  PostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name' : name,
      'uid' : uid,
      'image' : image,
      'dateTime' : dateTime,
      'text' : text,
      'postImage' : postImage,

    };
  }
}