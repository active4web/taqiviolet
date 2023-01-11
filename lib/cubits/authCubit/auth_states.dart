import 'package:safsofa/models/register_success_model.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class ChangePasswordVisibilityState extends AuthStates {}

class EmailSignupLoadingState extends AuthStates {}

class EmailSignupSuccessState extends AuthStates {
  final RegisterSuccessModel signUpModel;
  EmailSignupSuccessState(this.signUpModel);
}

class EmailSignupErrorState extends AuthStates {
  EmailSignupErrorState(this.errorMessage);
  final String errorMessage;
}

class PhoneSignupLoadingState extends AuthStates {}

class PhoneSignupSuccessState extends AuthStates {
  final RegisterSuccessModel signUpModel;
  PhoneSignupSuccessState(this.signUpModel);
}

class PhoneSignupErrorState extends AuthStates {
  PhoneSignupErrorState(this.errorMessage);
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

class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class LogoutErrorState extends AuthStates {}
