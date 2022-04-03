part of 'shops_cubit.dart';

@immutable
abstract class ShopsState {}

class ShopsInitial extends ShopsState {}

class ShopsLoading extends ShopsState {}

class ShopsSuccess extends ShopsState {}

class ShopsError extends ShopsState {}

///All Shops States
class AllShopsInitial extends ShopsState {}

class AllShopsLoading extends ShopsState {}

class AllShopsSuccess extends ShopsState {}

class AllShopsError extends ShopsState {}

class DectectListProduct extends ShopsState {}
