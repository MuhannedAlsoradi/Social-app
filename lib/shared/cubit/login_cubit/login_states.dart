abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginChangePasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
