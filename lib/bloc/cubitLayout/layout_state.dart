part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class LoadingGetUserDataState extends LayoutState {}

class SuccessGetUserDataState extends LayoutState {}

class FailedGetUserDataState extends LayoutState {
  final String error;

  FailedGetUserDataState(this.error);

}

class LoadingGetPostsDataState extends LayoutState {}

class LoadingLikePostsDataState extends LayoutState {}

class SuccessGetPostsDataState extends LayoutState {}
class SuccessChangeThemeModeState extends LayoutState {}

class FailedGetPostsDataState extends LayoutState {
  final String error;

  FailedGetPostsDataState(this.error);

}
class SuccessSendMessageDataState extends LayoutState {}

class FailedSendMessageDataState extends LayoutState {}

class SuccessReceivedMessageDataState extends LayoutState {}

class FailedReceivedMessageDataState extends LayoutState {}

class LoadingGetAllUsersDataState extends LayoutState {}

class SuccessGetAllUsersDataState extends LayoutState {}

class SuccessGetMessagesDataState extends LayoutState {}

class FailedGetAllUsersDataState extends LayoutState {
  final String error;

  FailedGetAllUsersDataState(this.error);

}
class SuccessLikePostsState extends LayoutState {}

class FailedLikePostsState extends LayoutState {
  final String error;

  FailedLikePostsState(this.error);

}

class ChangeIndexNavBarState extends LayoutState {}

class NewPostState extends LayoutState {}

class SuccessChangeCoverImageState extends LayoutState {}

class FailedChangeCoverImageState extends LayoutState {}

class SuccessChangeProfileImageState extends LayoutState {}

class FailedChangeProfileImageState extends LayoutState {}

class LoadingUploadProfileImageState extends LayoutState {}

class SuccessUploadProfileImageState extends LayoutState {}

class FailedUploadProfileImageState extends LayoutState {}

class SuccessGetPostImageState extends LayoutState {}

class FailedGetPostImageState extends LayoutState {}

class LoadingUploadCoverImageState extends LayoutState {}

class SuccessUploadCoverImageState extends LayoutState {}

class FailedUploadCoverImageState extends LayoutState {}

class LoadingUpdateUserDataImagesState extends LayoutState {}

class LoadingUpdateUserDataState extends LayoutState {}

class SuccessUpdateUserDataState extends LayoutState {}

class FailedUpdateUserDataState extends LayoutState {
  final String error;

  FailedUpdateUserDataState(this.error);
}


class LoadingUploadPostImageState extends LayoutState {}

class SuccessUploadPostImageState extends LayoutState {}

class FailedUploadPostImageState extends LayoutState {}


class LoadingCreatePostDataState extends LayoutState {}

class SuccessCreatePostDataState extends LayoutState {}

class FailedCreatePostDataState extends LayoutState {
  final String error;

  FailedCreatePostDataState(this.error);
}
class SuccessRemovePostImageState extends LayoutState {}





