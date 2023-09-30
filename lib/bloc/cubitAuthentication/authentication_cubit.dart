import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/user_model/user_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  bool password = false;

  void ChangeVisiablePassword() {
    password = !password;
    emit(ChangeFirstPasswordState());
  }

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid)
          .get().then((value) {
        model = UserModel.fromJson(value.data()!);
        print(model!.name);
        emit(SuccessLoginState(value.id));
      }).catchError((error) {
        print(error.toString());
        emit(FailedLoginState(error.toString()));
      });

    }).catchError((error) {
      emit(FailedLoginState(error.toString()));
    });
  }

  void UserSignUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(LoadingSignupState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      UserCreate(
          image: 'https://img.freepik.com/free-photo/beautiful-young-woman-looking-camera_1301-3389.jpg?w=360&t=st=1695387283~exp=1695387883~hmac=f56b386d1bf581601471adcfd28f9212a8f450ce53ac2df08e3edb0bf08950c6',
          bio: 'Write your bio...',
          cover: 'https://img.freepik.com/free-photo/man-is-editing-photos-laptop-using-graphics-tablet-interactive-pen-display_8353-6239.jpg?w=1060&t=st=1695387197~exp=1695387797~hmac=9c86fff30f11c615a767a1afb3fb6ea1a446fc9071e18cb78619fe93b3f22d80',
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid
      );
      emit(SuccessSignupState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedSignupState(error.toString()));
    });
  }

  UserModel ?model;



  void UserCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required bio,
    required cover,
    required image
  }) {
    emit(LoadingCreateState());
    model = UserModel(
        name: name,
        isEmailVerified: false,
        bio: 'Write your bio...',
        cover: 'https://img.freepik.com/free-photo/business-concept-close-up-portrait-young-beautiful-attractive-redhair-girl-smiling-showing-blank-sig_1258-116838.jpg?w=1380&t=st=1695840576~exp=1695841176~hmac=620542fb542be57e043c59d0819aa90dbc81aac215e3d2f45f54d533a98d7b45',
        image: 'https://img.freepik.com/premium-photo/user-icon-person-symbol-human-avatar-3d-render_473931-217.jpg?w=740',
        email: email,
        phone: phone,
        uId: uId);
    FirebaseFirestore.instance.collection('users').doc(uId)
        .set(model!.toMap())
        .then((value) {
      emit(SuccessCreateState(uId));
    }).catchError((error) {
      emit(FailedCreateState(error.toString()));
    });
  }


}
