abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorsState extends AppStates {
  final String error;

  AppGetUserErrorsState(this.error);
}

class AppChangeBottomNavBarState extends AppStates {}

class AppNewPostState extends AppStates {}

class ProfileImageSuccessState extends AppStates {}

class CoverImageSuccessState extends AppStates {}

class ProfileImageErrorState extends AppStates {}

class CoverImageErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

class AppUpdateUserLoadingState extends AppStates {}

class AppUpdateUserErrorsState extends AppStates {
  final String error;

  AppUpdateUserErrorsState(this.error);
}

class PostImagePickSuccessState extends AppStates {}

class PostImagePickErrorState extends AppStates {}

class UploadPostImageSuccessState extends AppStates {}

class UploadPostImageErrorState extends AppStates {}

class UploadPostImageLoadingState extends AppStates {}

class RemovePostImageSuccessState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class AppGetPostsLoadingState extends AppStates {}

class AppGetPostsSuccessState extends AppStates {}

class AppGetPostsErrorsState extends AppStates {
  final String error;

  AppGetPostsErrorsState(this.error);
}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

class CommentPostSuccessState extends AppStates {}

class CommentPostErrorState extends AppStates {}

class AppGetAllUserLoadingState extends AppStates {}

class AppGetAllUserSuccessState extends AppStates {}

class AppGetAllUserErrorsState extends AppStates {
  final String error;

  AppGetAllUserErrorsState(this.error);
}

class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {}

class GetAllMessagesErrorState extends AppStates {}

class GetAllMessagesSuccessState extends AppStates {}
