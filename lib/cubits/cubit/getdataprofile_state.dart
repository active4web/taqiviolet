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
class ChangeIndex extends GetdataprofileState{}


/*
class ShowAndHideOldPassword extends GetdataprofileState{}
class ShowAndHideNewPassword extends GetdataprofileState{}
class ShowAndHideConfirmPassword extends GetdataprofileState{}*/

class ResetPasswordLoadingState extends GetdataprofileState{}

class ResetPasswordSuccessState extends GetdataprofileState{

}

class ResetPasswordErrorState extends GetdataprofileState{
final String error;

  ResetPasswordErrorState(this.error);
}


class UpdateProfileLoadingState extends GetdataprofileState{}
class UpdateProfileSuccessState extends GetdataprofileState{}
class UpdateProfileErrorState extends GetdataprofileState{}