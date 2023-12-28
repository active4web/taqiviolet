abstract class TechnicalSupportState {}

class TechnicalSupportInitial extends TechnicalSupportState {}

class GetContactUsLoadingState extends TechnicalSupportState {}

class GetContactUsSuccessState extends TechnicalSupportState {}

class GetContactUsErrorState extends TechnicalSupportState {}

class ContactUsSendingSuccessState extends TechnicalSupportState {}

class ContactUsSendingLoadingState extends TechnicalSupportState {}

class ContactUsSendingErrorState extends TechnicalSupportState {
  String error;

  ContactUsSendingErrorState(this.error);
}
//
// class GetTechnicalSupportLoadingState extends TechnicalSupportState{}
//
// class GetTechnicalSupportSuccessState extends TechnicalSupportState{}
//
// class GetTechnicalSupportErrorState extends TechnicalSupportState{}
