
abstract class ReceiptRecordState {}

class ReceiptRecordInitial extends ReceiptRecordState {}
class ChangeSelectedEmployeeSuccessState extends ReceiptRecordState {}
class GetEmployeesLoadingState extends ReceiptRecordState {}
class GetEmployeesSuccessState extends ReceiptRecordState {}
class GetEmployeesErrorState extends ReceiptRecordState {
  final String error;

  GetEmployeesErrorState({
    required this.error});
}

class SendReceiptRecordFormDataLoadingState extends ReceiptRecordState {}
class SendReceiptRecordFormDataSuccessState extends ReceiptRecordState {}
class SendReceiptRecordFormDataErrorState extends ReceiptRecordState {
  final String error;

  SendReceiptRecordFormDataErrorState({
    required this.error});
}

class GetSignatureLoadingState extends ReceiptRecordState {}
class GetSignatureSuccessState extends ReceiptRecordState {}
class GetSignatureErrorState extends ReceiptRecordState {
  final String error;

  GetSignatureErrorState({
    required this.error});
}


class GetReceiptRecordDataLoadingState extends ReceiptRecordState {}
class GetReceiptRecordDataSuccessState extends ReceiptRecordState {}
class GetReceiptRecordDataErrorState extends ReceiptRecordState {
  final String error;

  GetReceiptRecordDataErrorState({
    required this.error});
}