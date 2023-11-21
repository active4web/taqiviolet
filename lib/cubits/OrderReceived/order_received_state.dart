part of 'order_received_cubit.dart';

@immutable
abstract class OrderReceivedState {}

class OrderReceivedInitial extends OrderReceivedState {}
class OrderReceivedLoadingState extends OrderReceivedState{}
class OrderReceivedSuccessState extends OrderReceivedState{}
class OrderReceivedErrorState extends OrderReceivedState{}