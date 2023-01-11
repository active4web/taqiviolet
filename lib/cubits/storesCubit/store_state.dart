part of 'stores_cubit.dart';

@immutable
abstract class StoresState {}

class ShopsInitial extends StoresState {}

class ShopsLoading extends StoresState {}

class ShopsSuccess extends StoresState {}

class ShopsError extends StoresState {}

///All Shops States
class AllShopsInitial extends StoresState {}

class AllShopsLoading extends StoresState {}

class AllShopsSuccess extends StoresState {}

class AllShopsError extends StoresState {}

class DectectListProduct extends StoresState {}

class StoreCategoryLoadingState extends StoresState {}
 class StoreCategorySuccessState extends StoresState {}
 class StoreCategoryErrorState extends StoresState {}
