
abstract class StartingWorkState {}

class StartingWorkInitial extends StartingWorkState {}
class ChangeSelectedEmployeeSuccessState extends StartingWorkState {}
class GetEmployeesLoadingState extends StartingWorkState {}
class GetEmployeesSuccessState extends StartingWorkState {}
class GetEmployeesErrorState extends StartingWorkState {
  final String error;

  GetEmployeesErrorState({
    required this.error});
}

class SendStartWorkFormDataLoadingState extends StartingWorkState {}
class SendStartWorkFormDataSuccessState extends StartingWorkState {}
class SendStartWorkFormDataErrorState extends StartingWorkState {
  final String error;

  SendStartWorkFormDataErrorState({
    required this.error});
}


class ClearAllDataSuccessState extends StartingWorkState {}
class GetSignatureLoadingState extends StartingWorkState {}
class GetSignatureSuccessState extends StartingWorkState {}
class GetSignatureErrorState extends StartingWorkState {
  final String error;

  GetSignatureErrorState({
    required this.error});
}

class GetStartWorkDataLoadingState extends StartingWorkState {}
class GetStartWorkDataSuccessState extends StartingWorkState {}
class GetStartWorkDataErrorState extends StartingWorkState  {
  final String error;

  GetStartWorkDataErrorState({
    required this.error});
}
