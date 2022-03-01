abstract class SocialStates{}
class SocialInitialState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

//get all users
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}
//get posts
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}
class SocialNewsPostState extends SocialStates{}
class SocialProfileImagePickSuccessState extends SocialStates{}
class SocialProfileImagePickErrorState extends SocialStates{}

class SocialUploadProfileImagePickSuccessState extends SocialStates{}
class SocialUploadProfileImagePickErrorState extends SocialStates{}

class SocialCoverImagePickSuccessState extends SocialStates{}
class SocialCoverImagePickErrorState extends SocialStates{}

class SocialPostImagePickSuccessState extends SocialStates{}
class SocialPostImagePickErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{}

class SocialLoadingUploadingUserDataState extends SocialStates{}

//create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//like posts
class SocialLikePostLoadingState extends SocialStates{}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}
//comment on a post
class SocialCommentPostLoadingState extends SocialStates{}
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}

class SocialShowSendCommentState extends SocialStates{}


//chat
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessagesSuccessState extends SocialStates{}
class SocialGetMessagesErrorState extends SocialStates{}

//comments
class SocialGetCommentsLoadingState extends SocialStates{}
class SocialGetCommentsSuccessState extends SocialStates{}
class SocialGetCommentsErrorState extends SocialStates{
  final String error;

  SocialGetCommentsErrorState(this.error);
}

//likes
class SocialGetLikesLoadingState extends SocialStates{}
class SocialGetLikesSuccessState extends SocialStates{}
class SocialGetLikesErrorState extends SocialStates{
  final String error;

  SocialGetLikesErrorState(this.error);
}