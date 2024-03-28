abstract class CartState {}

class CartStateInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {}

class CartErrorState extends CartState {}
class ChoseCityState extends CartState {}
class ChoseCountryState extends CartState {}

class MakeNewOrderErrorState extends CartState {}
class MakeNewOrderSuccessState extends CartState {}
class MakeNewOrderLoadingState extends CartState {}

class CheckPromoErrorState extends CartState {}
class CheckPromoSuccessState extends CartState {}
class CheckPromoLoadingState extends CartState {}
class ChangeActive extends CartState {}

class GetCountriesErrorState extends CartState {}
class GetCountriesSuccessState extends CartState {}
class GetCountriesLoadingState extends CartState {}


class CacheBackErrorState extends CartState {}
class CacheBackSuccessState extends CartState {}
class CacheBackLoadingState extends CartState {}
class CancelPromoCode extends CartState {}

class DeleteCartSuccessState extends CartState{}
class DeleteCartLoadingState extends CartState{}
class DeleteCartErrorState extends CartState{}