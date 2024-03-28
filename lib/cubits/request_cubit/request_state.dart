part of 'request_cubit.dart';

@immutable
abstract class RequestState {}

class RequestInitial extends RequestState {}

class GetRequestSuccessState extends RequestState {}
class GetRequestLoadingState extends RequestState {}
class GetRequestErrorState extends RequestState {}

class ChangeStatusSuccess extends RequestState {}
class ChangeStatusLoading extends RequestState {}
class ChangeStatusError extends RequestState {}
