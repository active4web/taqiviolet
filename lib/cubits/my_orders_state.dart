part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoadingState extends MyOrdersState{}
class MyOrdersSuccessState extends MyOrdersState{}
class MyOrdersErrorState extends MyOrdersState{}
