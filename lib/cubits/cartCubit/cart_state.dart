abstract class CartState {}

class CartStateInitial extends CartState {}
class CartLoadingState  extends CartState {}
class CartStateSuccessState extends CartState {}
class CartStateErrorState extends CartState {}