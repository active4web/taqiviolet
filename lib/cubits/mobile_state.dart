part of 'mobile_cubit.dart';

@immutable
abstract class MobileState {}

class MobileInitial extends MobileState {}
class MobileLoadingState extends MobileState{}
class MobileSuccessState extends MobileState{}
class MobileErrorState extends MobileState{}