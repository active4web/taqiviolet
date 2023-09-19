
abstract class VacationState {}

class VacationInitial extends VacationState {}
class GetEmployeesLoadingState extends VacationState {}
class GetEmployeesSuccessState extends VacationState {}
class GetEmployeesErrorState extends VacationState {
  final String error;

  GetEmployeesErrorState({
    required this.error});
}

class ChangeSelectedEmployeeSuccessState extends VacationState {}
class SendVacationFormDataLoadingState extends VacationState {}
class SendVacationFormDataSuccessState extends VacationState {}
class SendVacationFormDataErrorState extends VacationState {
  final String error;

  SendVacationFormDataErrorState({
    required this.error});
}
class GetSignatureLoadingState extends VacationState {}
class GetSignatureSuccessState extends VacationState {}
class GetSignatureErrorState extends VacationState {
  final String error;

  GetSignatureErrorState({
    required this.error});
}

class ChangePunishmentTypeSuccessState extends VacationState {}
class ClearAllDataSuccessState extends VacationState {}


class GetVacationsDataLoadingState extends VacationState {}
class GetVacationsDataSuccessState extends VacationState {}
class GetVacationsDataErrorState extends VacationState {
  final String error;

  GetVacationsDataErrorState({
    required this.error});
}