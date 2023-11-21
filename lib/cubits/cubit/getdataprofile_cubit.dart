import 'dart:developer';

import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/models/reset_password_model.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/get_data_profile_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'package:dio/dio.dart';
part 'getdataprofile_state.dart';

class GetdataprofileCubit extends Cubit<GetdataprofileState> {
  GetdataprofileCubit() : super(GetdataprofileInitial());
  static GetdataprofileCubit get(context) => BlocProvider.of(context);

/*
  IconData suffixOldPassword = Icons.visibility_off_outlined;
  bool isPasswordOldPassword = true;

  void isShowAndHideOldPassword() {
    isPasswordOldPassword = !isPasswordOldPassword;
    suffixOldPassword = isPasswordOldPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideOldPassword());
  }
  IconData suffixNewPassword = Icons.visibility_off_outlined;
  bool isPasswordNewPassword = true;

  void isShowAndHideNewPassword() {
    isPasswordNewPassword = !isPasswordNewPassword;
    suffixNewPassword = isPasswordNewPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideNewPassword());
  }
  IconData suffixConfirmPassword = Icons.visibility_off_outlined;
  bool isPasswordConfirmPassword = true;

  void isShowAndHideConfirmPassword() {
    isPasswordConfirmPassword = !isPasswordConfirmPassword;
    suffixConfirmPassword = isPasswordConfirmPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideConfirmPassword());
  }
*/
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool chooseName = false;
  bool chooseAddress = false;
  bool chooseResetPassword = false;
  bool chooseDeleteMyAccount = false;

  changeChooseName(){
    chooseName=!chooseName;
    emit(ChangeIndex());
  }
  changeChooseAddress(){
    chooseAddress=!chooseAddress;
    emit(ChangeIndex());
  }
  changeChooseResetPassword(){
    chooseResetPassword=!chooseResetPassword;
    emit(ChangeIndex());
  }
  changeChooseDeleteMyAccount(){
    chooseDeleteMyAccount=!chooseDeleteMyAccount;
    emit(ChangeIndex());
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
   TextEditingController resetPasswordC = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  GetdataprofileModel? getDataProfileModel;
  void getdataprofileCData() {
    emit(GetdataprofileInitialLoadingState());
    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: kToken,
      url: userProfile,
    ).then((value) {
      print("Bisho ${value.data}");
      getDataProfileModel = GetdataprofileModel.fromJson(value.data);
      name.text=getDataProfileModel?.data?.name??'';
      address.text=getDataProfileModel?.data?.address??'';

      emit(GetdataprofileInitialSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetdataprofileInitialErrorState());
    });
  }

  ResetPasswordModel? resetPasswordModel;
  void resetPasswordData({
    required String oldPassword,
  required String newPassword,
}){
    emit(ResetPasswordLoadingState());
    Mhelper.postData(
      token: kToken,
      url: resetPassword,
      data: {
        "oldpassword":oldPassword,
        "newpassword":newPassword,
      }
    ).then((value) {
      print(value.data);
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);
      if(resetPasswordModel?.status == true){
        showToast(
            text:
            "${resetPasswordModel?.msg}",
            color: Colors.black,
         );

        emit(ResetPasswordSuccessState());
      }else{
        showToast(
          text:
          "${resetPasswordModel?.msg}",
          color: Colors.black,
        );
        emit(ResetPasswordErrorState("${resetPasswordModel?.msg}"));
      }
    }).catchError((error){
      print(error.toString());
      emit(ResetPasswordErrorState(error.toString()));
    });
  }

  void postDataProfile({ id}) async {
    emit(UpdateProfileLoadingState());
    Mhelper.postData(url: editProfile, data: {
      "phone": phone.text,
      "id": id,
      "name": name.text,
      "email": email.text,
      "address": address.text,
      // "image": await MultipartFile.fromFile(imageFile!.path,
      //     filename: imageFile?.name.split('/').last)
    }).then((value) {
      print(value.data);
      showToast(text: "${value.data["msg"]}", color: Colors.green);
      emit(UpdateProfileSuccessState());
       getdataprofileCData();
    }).catchError((error){
      emit(UpdateProfileErrorState());
      print("error in update profile ${error.toString()}");
    });
  }

  XFile? imageFile;
  void selectImage() async {
    final XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imageFile = selectedImage;
    }
    emit(GetdataprofileInitialSuccessState());
  }

}
