part of 'sub_cat_cubit.dart';

@immutable
abstract class SubCatState {}

class SubCatInitial extends SubCatState {}

///States of SubCategory in Home Screen
class HomeSubCatLoading extends SubCatState {}

class HomeSubCatSuccess extends SubCatState {}

class HomeSubCatError extends SubCatState {}

///End of SubCat States

///States of SubCategory in Home Screen
class ProductLoading extends SubCatState {}

class ProductSuccess extends SubCatState {}

class ProductError extends SubCatState {}

///TODO:End of SubCat States
