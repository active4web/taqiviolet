import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safsofa/cubits/commitments/commitments_cubit.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit._() : super(ForgotPasswordInitial());

  static final instance=ForgotPasswordCubit._();
  static ForgotPasswordCubit get(context)=>BlocProvider.of(context);

  StreamController<ErrorAnimationType>? errorAnimationController;
  var textEditingController=TextEditingController();
  var emailController=TextEditingController();
var formKey=GlobalKey<FormState>();
  bool email=false;
  changeSelect(){
    email=!email;
    emit(ChangeSelectState());
  }
  Future<void>forgotPassword()async{
    emit(SendVerifyCodeLoadingState());
    final response=await Mhelper.postData(url: 'api/forgot-password',data: {
      "email":emailController.text
    },query: {
      "lang":kLanguage
    });
    if(response.data['status']){
      emit(SendVerifyCodeSuccessState());
    }else{
      emit(SendVerifyCodeErrorState(
        response.data['errors']['email']
      ));
    }
}

  Future<void>checkCode()async{
    emit(CheckCodeLoadingState());
    final response=await Mhelper.postData(url: 'api/check-password-code',data: {
      "code":textEditingController.text
    },query: {
      "lang":kLanguage

    });
    if(response.data['status']){
      emit(CheckCodeSuccessState());
      showToast(text: response.data['message'], color: kCustomBlack);
    }else{
      emit(CheckCodeErrorState());
      showToast(text: response.data['errors']['code'], color: kCustomBlack);

    }

  }

  bool isPassword=true;
  void changeShowPassState(){
    isPassword=!isPassword;
    emit(ChangeShowPassState());
  }
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  Future<void>changePassword()async{
    emit(ChangePasswordLoadingState());
    final response=await Mhelper.postData(url: "api/reset-new-password",
    data: {
      "code":textEditingController.text,
      "password":passwordController.text,
      "password_confirmation":confirmPasswordController.text
    },query: {
          "lang":kLanguage
        }
    );
    if(response.data['status']){
      emit(ChangePasswordSuccessState());
      clearControllers();
      email=false;
      showToast(text: 'تم تغيير كلمة المرور بنجاح', color: kCustomBlack);
    }else{
      emit(ChangePasswordErrorState());

    }
  }

clearControllers(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    textEditingController.clear();

}

}
