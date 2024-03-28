part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class SendVerifyCodeSuccessState extends ForgotPasswordState {}
class SendVerifyCodeErrorState extends ForgotPasswordState {
  final String error;
  SendVerifyCodeErrorState(this.error);
}
class SendVerifyCodeLoadingState extends ForgotPasswordState {}

class ChangeSelectState extends ForgotPasswordState {}

class CheckCodeSuccessState extends ForgotPasswordState {}
class CheckCodeErrorState extends ForgotPasswordState {
}
class CheckCodeLoadingState extends ForgotPasswordState {}
class ChangeShowPassState extends ForgotPasswordState {}
class ChangePasswordSuccessState extends ForgotPasswordState {}
class ChangePasswordLoadingState extends ForgotPasswordState {}
class ChangePasswordErrorState extends ForgotPasswordState {}

