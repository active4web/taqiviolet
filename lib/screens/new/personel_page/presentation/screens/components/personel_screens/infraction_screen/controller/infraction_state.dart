
abstract class InfractionState {}

class InfractionInitial extends InfractionState {}
class GetEmployeesLoadingState extends InfractionState {}
class GetEmployeesSuccessState extends InfractionState {}
class GetEmployeesErrorState extends InfractionState {
  final String error;

  GetEmployeesErrorState({
    required this.error});
}

class ChangeSelectedEmployeeSuccessState extends InfractionState {}
class SendInfractionFormDataLoadingState extends InfractionState {}
class SendInfractionFormDataSuccessState extends InfractionState {}
class SendInfractionFormDataErrorState extends InfractionState {
  final String error;

  SendInfractionFormDataErrorState({
    required this.error});
}
class GetSignatureLoadingState extends InfractionState {}
class GetSignatureSuccessState extends InfractionState {}
class GetSignatureErrorState extends InfractionState {
  final String error;

  GetSignatureErrorState({
    required this.error});
}

class ChangePunishmentTypeSuccessState extends InfractionState {}
class ClearAllDataSuccessState extends InfractionState {}

class GetInfractionDataLoadingState extends InfractionState {}
class GetInfractionDataSuccessState extends InfractionState {}
class GetInfractionDataErrorState extends InfractionState {
  final String error;

  GetInfractionDataErrorState({
    required this.error});
}