
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentLoadingState extends PaymentState {}
class PaymentSuccessState extends PaymentState {}
class PaymentErrorState extends PaymentState {}


class UpdateOrderLoadingState extends PaymentState {}
class UpdateOrderSuccessState extends PaymentState {}
class UpdateOrderErrorState extends PaymentState {}
class ChangePay extends PaymentState {}
