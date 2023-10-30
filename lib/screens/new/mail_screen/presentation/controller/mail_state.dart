
abstract class MailState {}

class MailInitial extends MailState {}


class GetInboxSuccessState extends MailState {}
class GetInboxLoadingState extends MailState {}
class GetInboxErrorState extends MailState {}

class GetOutboxSuccessState extends MailState {}
class GetOutboxLoadingState extends MailState {}
class GetOutboxErrorState extends MailState {}

class GetMessageDetailsSuccessState extends MailState {}
class GetMessageDetailsLoadingState extends MailState {}
class GetMessageDetailsErrorState extends MailState {}


class ReplayMessageSuccessState extends MailState {}
class ReplayMessageLoadingState extends MailState {}
class ReplayMessageErrorState extends MailState {}







class SendEmailLoadingState extends MailState {}

class SendEmailSuccessState extends MailState {}

class SendEmailSuccessWithExceptionState extends MailState {
  final String message;

  SendEmailSuccessWithExceptionState({required this.message});
}
class SendEmailErrorState extends MailState {
  final String error;

  SendEmailErrorState({required this.error});
}

class GetPhoneOwnerLoadingState extends MailState {}

class GetPhoneOwnerSuccessState extends MailState {
  final String name;

  GetPhoneOwnerSuccessState({required this.name});
}

class GetPhoneOwnerSuccessWithExceptionState extends MailState {
  final String message;

  GetPhoneOwnerSuccessWithExceptionState({required this.message});
}
class GetPhoneOwnerErrorState extends MailState {
  final String error;

  GetPhoneOwnerErrorState({required this.error});
}