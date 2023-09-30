import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/New_post_screen.dart';

import '../../modules/chat_screen.dart';
import '../../modules/home_screen.dart';
import '../../modules/setting_screen.dart';
import '../../modules/user_screen.dart';
import '../../shared/component/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  UserModel? model;

  void GetUserData() {
    emit(LoadingGetUserDataState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print(model!.cover);
      emit(SuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetUserDataState(error.toString()));
    });
  }

  List<Widget> screen = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen()
  ];
  List title = ['Home', 'Chats', 'Post', 'User', 'Profile'];
  int index = 0;

  void ChangeIndexNavBar(int i) {
    if (i == 1) {
      GetAllUsers();
    }
    if (i == 2) {
      emit(NewPostState());
    } else {
      index = i;
      emit(ChangeIndexNavBarState());
    }
  }

  File? profileImage;
  File? coverImage;
  File? postImage;

  var picker = ImagePicker();

  Future<void> GetProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SuccessChangeProfileImageState());
    } else {
      print('No Image Selected');
      emit(FailedChangeProfileImageState());
    }
  }

  Future<void> GetCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SuccessChangeCoverImageState());
    } else {
      print('No Image Selected');
      emit(SuccessChangeCoverImageState());
    }
  }

  String profileImageUrl = '';
  String coverImageUrl = '';
  String PostImageUrl = '';

  void UploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(LoadingUploadProfileImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(profileImageUrl);
        UpdateUserData(
            name: name, phone: phone, bio: bio, image: profileImageUrl);
        emit(SuccessUploadProfileImageState());
      }).catchError((error) {
        emit(FailedUploadProfileImageState());
      });
    }).catchError((error) {
      emit(FailedUploadProfileImageState());
    });
  }

  void UploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(LoadingUploadCoverImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        print(coverImageUrl);
        UpdateUserData(
            name: name, phone: phone, bio: bio, cover: coverImageUrl);
        emit(SuccessUploadCoverImageState());
      }).catchError((error) {
        emit(FailedUploadCoverImageState());
      });
    }).catchError((error) {
      emit(FailedUploadCoverImageState());
    });
  }

  void UpdateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    model = UserModel(
        name: name,
        email: model!.email,
        phone: phone,
        cover: coverImageUrl == '' ? model!.cover : coverImageUrl,
        bio: bio,
        image: profileImageUrl == '' ? model!.image : profileImageUrl,
        uId: uId,
        isEmailVerified: false);
    emit(LoadingUpdateUserDataState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model!.toMap())
        .then((value) {
      GetUserData();
      emit(SuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedUpdateUserDataState(error.toString()));
    });
  }

  Future<void> GetPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SuccessGetPostImageState());
    } else {
      print('No Image Selected');
      emit(FailedGetPostImageState());
    }
  }

  void CreatePostImage({
    required String text,
    required String dateTime,
  }) {
    emit(LoadingUploadPostImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        PostImageUrl = value;
        print(PostImageUrl);
        CreatePost(dateTime: dateTime, text: text, image: PostImageUrl);
        emit(SuccessUploadPostImageState());
      }).catchError((error) {
        emit(FailedUploadPostImageState());
      });
    }).catchError((error) {
      emit(FailedUploadPostImageState());
    });
  }

  void RemovePostImage() {
    postImage = null;
    emit(SuccessRemovePostImageState());
  }

  PostModel? postModel;

  void CreatePost({
    required String text,
    required String dateTime,
    String? image,
  }) {
    postModel = PostModel(
        name: model!.name,
        image: model!.image,
        uId: uId,
        text: text ?? '',
        dateTime: dateTime,
        postImage: image ?? '');
    emit(LoadingCreatePostDataState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toMap())
        .then((value) {
      emit(SuccessCreatePostDataState());
      GetPosts();
    }).catchError((error) {
      print(error.toString());
      emit(FailedCreatePostDataState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String>posdId = [];
  List<int>likes = [];

  void GetPosts() {
    posts.clear();
    posdId.clear();
    likes.clear();
    emit(LoadingGetPostsDataState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posdId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          print(value.docs.length);
          emit(LoadingGetPostsDataState());
        });
        print(element.id);
      });
      emit(SuccessGetPostsDataState());
    });
  }

  void LikePost(String id) {
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(id).collection('likes').doc(model!.uId).set({
      'like': true,
    }).then((value) {

      emit(SuccessLikePostsState());
    }).catchError((error) {
      emit(FailedLikePostsState(error.toString()));
    });
  }

  List<UserModel>users = [];

  void GetAllUsers() {
    users.clear();
    emit(LoadingGetAllUsersDataState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(SuccessGetAllUsersDataState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllUsersDataState(error.toString()));
    });
  }

  MessageModel ?messageModel;

  Future<int> getMessageCount(String receiverId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .get();

    int messageCount = querySnapshot.size;
    return messageCount;
  }

  Future<void> SendMessage({
    required String receiverId,
    required String dateTime,
    required String text
  }) async{

    messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      arrange: messages.length,
      receiverId: receiverId,
      senderId: uId,
    );
    FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').add(messageModel!.toMap()).then((value) {
          emit(SuccessSendMessageDataState());
    }).catchError((error){
      emit(FailedSendMessageDataState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages').add(messageModel!.toMap()).then((value) {
      emit(SuccessReceivedMessageDataState());
    }).catchError((error){
      emit(FailedReceivedMessageDataState());
    });
  }
  List<MessageModel>messages=[];
  void GetMessage({
    required String receiverId,
}){
    FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').
    orderBy("arrange", descending: false).
    snapshots().listen((event) {
      messages.clear();
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
        emit(SuccessGetMessagesDataState());
    });
  }
  bool mode=false;
  void ChangeMode(){
    mode=!mode;
    emit(SuccessChangeThemeModeState());
  }


}
