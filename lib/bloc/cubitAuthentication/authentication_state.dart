part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class ChangeFirstPasswordState extends AuthenticationState {}
class ChangeSecondPasswordState extends AuthenticationState {}
class LoadingLoginState extends AuthenticationState {}

class SuccessLoginState extends AuthenticationState {
  final String uId;

  SuccessLoginState(this.uId);
}

class FailedLoginState extends AuthenticationState {
  final String error;

  FailedLoginState(this.error);

}

class LoadingSignupState extends AuthenticationState {}

class SuccessSignupState extends AuthenticationState {}

class FailedSignupState extends AuthenticationState {
  final String error;

  FailedSignupState(this.error);
}

class LoadingCreateState extends AuthenticationState {}

class SuccessCreateState extends AuthenticationState {
  final String uId;

  SuccessCreateState(this.uId);

}

class FailedCreateState extends AuthenticationState {
  final String error;

  FailedCreateState(this.error);

}


class LoadingCreateLoginState extends AuthenticationState {}

class SuccessCreateLoginState extends AuthenticationState {
  final String uId;

  SuccessCreateLoginState(this.uId);

}

class FailedCreateLoginState extends AuthenticationState {
  final String error;

  FailedCreateLoginState(this.error);

}