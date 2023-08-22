abstract class CartState {}

class CartStateInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {}

class CartErrorState extends CartState {}

class MakeOrderErrorStateNew extends CartState {}
class MakeOrderSuccessStateNew extends CartState {}
class MakeOrderLoadingStateNew extends CartState {}
