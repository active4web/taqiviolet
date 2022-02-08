import 'package:safsofa/models/register_success_model.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class ChangePasswordVisibilityState extends AuthStates {}

class SignupLoadingState extends AuthStates {}

class SignupSuccessState extends AuthStates {
  SignupSuccessState(this.signupSuccessModel);
  final RegisterSuccessModel signupSuccessModel;
}

class SignupErrorState extends AuthStates {
  SignupErrorState(this.errorMessage);
  final String errorMessage;
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  LoginSuccessState(this.loginSuccessModel);
  final RegisterSuccessModel loginSuccessModel;
}

class LoginErrorState extends AuthStates {
  LoginErrorState(this.errorMessage);
  final String errorMessage;
}
