part of 'getdataprofile_cubit.dart';

@immutable
abstract class GetdataprofileState {}

class GetdataprofileInitial extends GetdataprofileState {}
class GetdataprofileInitialLoadingState extends GetdataprofileState{}

class GetdataprofileInitialSuccessState extends GetdataprofileState{}

class GetdataprofileInitialErrorState extends GetdataprofileState{}
class postdataprofileLoadingState extends GetdataprofileState{}
class postdataprofileSuccessState extends GetdataprofileState{}
class postdataprofileErrorState extends GetdataprofileState{}